json.array! @books do |book|
  json.id         book.id
  json.author     book.author
  json.title      book.title
  json.status     book.status
  json.popularity book.popularity
end
