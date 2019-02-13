# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name  { Faker::Name.first_name.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8') }
    last_name   { Faker::Name.last_name.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8') }
    email       { Faker::Internet.email.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8') }
    password    { Faker::Internet.password(6, 10) }
    librarian   { true }
  end
end
