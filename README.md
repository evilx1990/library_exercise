### Library

Приложение представляет собой имитацию работы книжной библиотеки.
Прежде всего пользователю необходимо зарегистрироваться и залогиниться, чтобы получить доступ к книгам.

После аутентификации у пользователя появляются возможности:
- Просмотреть список всех книг(включая список самых популярных книг)
- Добавить новую книгу
- Отредактировать/Удалить существующую книгу
- Взять/Вернуть книгу(Когда книга выдана -для других пользователей она становится недоступной. В списке книг в описании будет отображено имя пользователя, который она была выдана) 
- Поставить оценку книге(оценка ставится один раз, потом ее невозможно изменить/отменить)
- Оставить комментарий
- Просмотреть историю книги

Из особенностей хотелось бы отметить:
- Список популярных книг реализован в виде карусели
- Удаление книги из списка, возможность Взять/Вернуть книгу без перезагрузки страницы
- В приложении реализовано небольшое API



API:
Для начала работы с API сначала необходимо создать пользователя на сайте.
Далее получить token пользователя для формирования запросов:
GET:	libraryexercise.pp.ua/api/v1/users/token?email=USER_EMAIL&password=USER_PASSWORD
Если данные введены корректно, будет возвращен token в виде:	
token: USER_TOKEN

Получить список всех книг(список отсортирован по популярности, сначала популярные)
GET:	libraryexercise.pp.ua/api/v1/books?email=USER_EMAIL&token=USER_TOKEN
Пример ответа:

[
    {
        "id": "5c8113fe61dbb07062b698a4",
        "author": "Raynor Winn",
        "title": "The Salt Path : The Sunday Times bestseller, shortlisted for the 2018 Costa Biography Award & The Wainwright Prize",
        "status": true,
        "popularity": 7
    },
…more books...
]


Получить книгу по id:
GET: libraryexercise.pp.ua/api/v1/books/BOOK_ID?email=USER_EMAIL&token=USER_TOKEN
Пример ответа:

{
    "id": "5c8113fe61dbb07062b698a4",
    "image": IMAGE_URL
    "author": "Raynor Winn",
    "title": "The Salt Path : The Sunday Times bestseller, shortlisted for the 2018 Costa Biography Award & The Wainwright Prize\n",
    "description": " …Some descpirtion… ",
    "status": true,
    "rating": 0,
    "vote_count": 0,
    "taken_count": 7,
    "popularity": 7
}

Взять книгу:
PUT:	libraryexercise.pp.ua/api/v1/books/BOOK_ID/take?email=USER_EMAIL&token=USER_TOKEN
Взять можно только книгу со статусом true

Вернуть книгу:
PUT:	libraryexercise.pp.ua/api/v1/books/BOOK_ID/return?email=USER_EMAIL&token=USER_TOKEN

Поставить оценку:
POST:	libraryexercise.pp.ua/api/v1/books/BOOK_ID/vote?rating=YOUR_RATING&email=USER_EMAIL&token=USER_TOKEN

