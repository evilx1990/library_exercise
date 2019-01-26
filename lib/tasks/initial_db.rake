# frozen_string_literal: true

namespace :app do
  desc 'Filling database after first run application'
  task initial_db: :environment do
    Rake::Task['db:mongoid:drop'].invoke

    # create librarian account
    User.create!(
        first_name: 'admin',
        last_name: 'admin',
        email: 'librarian1@library.loc',
        password: 'Librarian1',
        librarian: true
    )

    Dir[Rails.root + "lib/assets/Books/*.jpg"].each(&method(:add_book_to_db))

  rescue
    puts $!.inspect
  end

  def add_book_to_db(file)
    File.open(file + '.txt', 'r') { |f| @lines = f.readlines }

    # select indexes headlines
    @title_index = @lines.index("title:\n")
    @author_index = @lines.index("author:\n")
    @description_index = @lines.index("description:\n")

    # select && join data
    @title = @lines[(@title_index + 1)...@author_index].join
    @author = @lines[(@author_index + 1)...@description_index].join
    @description = @lines[(@description_index + 1)...@lines.length].join

    # read image file
    @image = File.open(file, 'rb')

    Book.create!(
        image: @image,
        title: @title,
        author: @author,
        description: @description,
        user: User.first
    )
    puts "Book \"#{@title.chop}\" successfully added to database"

    @image.close
  end
end
