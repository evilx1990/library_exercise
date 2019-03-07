if @book
  json.id           @book.id
  json.image        request.protocol + request.host_with_port + @book.image.url
  json.author       @book.author
  json.title        @book.title
  json.description  @book.description
  json.status       @book.status
  json.rating       @book.rating
  json.vote_count   @book.votes_count
  json.taken_count  @book.taken_count
  json.popularity   @book.popularity
end