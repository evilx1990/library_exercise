# frozen_string_literal: true

namespace :app do
  desc 'Create librarian account'
  task create_librarian: :environment do
    login = "lib_#{SecureRandom.hex(3)}@library.loc"
    password = SecureRandom.hex(3)
    lib_count = User.where(librarian: true).count

    User.create!(
        first_name: "librarian_#{lib_count}",
        last_name: '_',
        email: login,
        password: password,
        librarian: true
    )

    print_login(login, password)

  rescue
    puts $!.inspect
  end

  desc 'Filling application database'
  task initial_db: :environment do
    Dir[Rails.root + "lib/assets/Books/*.jpg"].each(&method(:add_book_to_db))

  rescue
    puts $!.inspect
  end

  # task functions

  def add_book_to_db(file)
    File.open("#{file}.txt", 'r') { |f| @lines = f.readlines }

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

  def print_login(email, password)
    puts '-' * 50
    puts "librarian account:\n\n"
    puts "login: #{email}"
    puts "password: #{password}\n\n"
    puts 'Please change password after first login'
    puts '-' * 50
  end
end
