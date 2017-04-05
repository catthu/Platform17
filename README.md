# Platform 17

Work in progress. Text-based games engine and content.

Detailed design and progress recorded in journal.md

## Installation

The project is nowhere near complete yet, but if you'd like to clone the project and run it on your local machine, follow these steps:

1. Clone the repo
2. Install dependencies as specified in `requirements.txt`
3. Set up a PostgreSQL database, configure it in `settings.py`
4. Import the current database with `dbexport.pgsql`
5. Start the Redis server:
```
$ redis-server
```
6. Start daphne:
```
`daphne -b 0.0.0.0 -p 8000 terminal.asgi:channel_layer`
```
7. Start a worker:
```
`python manage.py runworker`
```

Enjoy!

## Demo

Alternatively, check the current state of the project out [here](platform17.herokuapp.com).

## Status

As of 4/5/2017, the app has:

- A user creation and authentication system (but no password retrieval yet, sorry)
- Complete and working front-end terminal interface
- Working ORM models for rooms and characters
- Globally support SAY, LOOK (and LOOK ME), MEOW
- Websocket intergration that pushes SAY commands to characters in the same room

## In Progress

- Basic item models and OOP design
- Object matching
- Anti-cheating security check
- Better separation of apps, and of engine and contents

## License: MIT

