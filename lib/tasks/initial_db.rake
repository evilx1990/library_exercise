# frozen_string_literal: true

namespace :app do
  desc 'Create user account'
  task create_user: :environment do
    login = "user_#{SecureRandom.hex(3)}@library.loc"
    password = SecureRandom.hex(3)

    User.create!(
      first_name: "User_#{User.count}",
      last_name: '...',
      email: login,
      password: password,
    )

    print_login(login, password)

  rescue
    puts $ERROR_INFO.inspect
  end

  desc 'Filling application database'
  task fill_db: :environment do
    Dir[Rails.root + 'lib/assets/books/*.jpg'].each(&method(:add_book_to_db))

  rescue
    puts $ERROR_INFO.inspect
  end

  # task functions

  def add_book_to_db(file)
    File.open("#{file[/^[^.]+/]}.txt", 'r') { |f| @lines = f.readlines }

    # select indexes headlines
    @title_index = @lines.index("title:\n")
    @author_index = @lines.index("author:\n")
    @desc_index = @lines.index("description:\n")

    # select && join data
    @title = @lines[(@title_index + 1)...@author_index].join
    @author = @lines[(@author_index + 1)...@desc_index].map(&:strip).join(', ')
    @description = @lines[(@desc_index + 1)...@lines.length].join

    # read image file
    @image = File.open(file, 'rb')

    Book.create!(
      image: @image,
      title: @title,
      author: @author,
      description: @description,
      user: User.first
    )

    puts "\"#{@title.chop}\" successfully added to database"

    @image.close
  end

  def print_login(email, password)
    puts '=' * 50
    puts "User account:\n\n"
    puts "login: #{email}"
    puts "password: #{password}\n\n"
    puts '=' * 50
  end
end
