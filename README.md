### Source task: 
[Readme](https://github.com/drkmen/library_exercise/blob/master/README.md)

### Library

The application is a simulation of the work of the book library.
First of all, the user needs to register and log in to access the books.

After authentication, the user has the opportunity:
- View a list of all books (including a list of the most popular books)
- Add new book
- Edit / Delete existing book
- Take / Return a book (When a book is issued, it becomes unavailable for other users. The name of the user that was issued will be displayed in the list of books in the description)
- Rate a book (assessment is made once, then it can not be changed/canceled)
- Leave a comment
- Viewbook history

Of the features I would like to note:
- A list of popular books implemented in the form of a carousel
- Removing a book from the list, the ability to Take / Return a book without reloading the page
- The application has a small API


### API:
To get started with the API, you must first create a user on the site.
Next, get the token user to form requests:
```
GET:	libraryexercise.pp.ua/api/v1/users/token?email=USER_EMAIL&password=USER_PASSWORD
```
If the data is entered correctly, it will be returned the user token:
token: USER_TOKEN
***
Get a list of all books (sorted by popularity, first popular)
```
GET:    libraryexercise.pp.ua/api/v1/books?email=USER_EMAIL&token=USER_TOKEN
```
Sample response:
```json
[
    {
        "id": "5c8113fe61dbb07062b698a4",
        "author": "Raynor Winn",
        "title": "The Salt Path : The Sunday Times bestseller, shortlisted for the 2018 Costa Biography Award & The Wainwright Prize",
        "status": true,
        "popularity": 7
    }
]
```

Get the book by id:
```
GET: libraryexercise.pp.ua/api/v1/books/BOOK_ID?email=USER_EMAIL&token=USER_TOKEN
```
Sample response:
```json
{
    "id": "5c8113fe61dbb07062b698a4",
    "image": "IMAGE_URL",
    "author": "Raynor Winn",
    "title": "The Salt Path : The Sunday Times bestseller, shortlisted for the 2018 Costa Biography Award & The Wainwright Prize\n",
    "description": " …Some descpirtion… ",
    "status": true,
    "rating": 0,
    "vote_count": 0,
    "taken_count": 7,
    "popularity": 7
}
```
***
Take the book:
```
PUT:	libraryexercise.pp.ua/api/v1/books/BOOK_ID/take?email=USER_EMAIL&token=USER_TOKEN
```
You can only take the book with the status of true
***
Return the book:
```
PUT:	libraryexercise.pp.ua/api/v1/books/BOOK_ID/return?email=USER_EMAIL&token=USER_TOKEN
```
***
Rate the book:
```
POST:	libraryexercise.pp.ua/api/v1/books/BOOK_ID/vote?rating=YOUR_RATING&email=USER_EMAIL&token=USER_TOKEN
```
