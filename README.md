# Проект "Mitoushi"

### Идея
Интерактивная таблица иероглифов для изучения.

### Реализовано
- добавление иероглифа в БД
- изменение иероглифа
- удаление иероглифа
- отправка всех иероглифов из БД на клиент и построение таблицы
- создание индивидуальной карточки иероглифа при кликанье на нём
- добавление пользователей в БД с раздачей прав

### Использовано
- NodeJS
- ExpressJS
- MongoDB
- GulpJS
- ReactJS

### Написано на
- CoffeScript
- Jade
- Styus

###Установка
##### Клонирование репозитория
```
git clone https://github.com/Amenoniku/Mitoushi.git
```
##### Установка `NodeJS`

- Перейти по [ссылке](https://nodejs.org/), скачать последнюю версию и установить

##### Установка `MongoDB`

- Перейти по [ссылке](https://www.mongodb.org/downloads#production) и скачать под нужную ОС
- Установить mongo и запустить по [инструкции(для Windows)](https://docs.mongodb.org/manual/tutorial/install-mongodb-on-windows/#install-mongodb)

##### Установка зависимостей
```
 npm i
```
##### Установка CoffeeScript глобально
```
 npm i -g coffee-script
```

* Для теста БД раскомментировать в файле core/app.coffee стоку 19 `require "./database"`

##### Запуск Проекта:
```
 npm start
```

* Открыть в браузере [http://localhost:8000/](http://localhost:8000/).
