# Task from job interview

Необходимо разработать webchat.

После захода на главную страницу пользователь вводит свое имя и попадает на страницу созданных чатов. Выбирает тот чат, где хочет общаться либо создает новый.
Каждое сообщение, которое пишет пользователь автоматом попадает в конец текущего чата у всех пользователей сразу.

Сообщения хранятся в БД.

Внешний вид существенной роли не играет. Можно использовать стандартный bootstrap. 

По желанию использовать websockets встроенные в Phoenix. 

Желательно unittest всего проекта.

Реализация проекта на Elixir с использованием Phoenix.


## How to run
```shell
docker-compose up --build -d
```
Open [`localhost:4000`](http://localhost:4000) from your browser.

## How it looks
![Screenshot](/screenshot.png?raw=true "Screenshot of existing room with messages")
