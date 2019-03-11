json.array! @books do |book|
  json.id         book['_id'].to_s
  json.author     book.author
  json.title      book.title
  json.status     book.status
  json.popularity book.popularity
end
