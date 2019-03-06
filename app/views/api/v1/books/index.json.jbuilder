json.all_books @books do |book|
  json.id         book.id
  json.author     book.author
  json.title      book.title
  json.status     book.status
end
