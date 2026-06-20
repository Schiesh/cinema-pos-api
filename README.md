# Cinema POS API

## Status

Currently in active development.

A Ruby on Rails REST API backend for a cinema Point of Sale (POS) system.
Built with Rails 8.1, PostgreSQL, and deployed on Ubuntu Server 24.04.

## Features

- **Movies** — full CRUD management of the movie catalog
- **Screens** — manage cinema screens with configurable types (Standard, PLF, IMAX, 4DX)
- **Seat Maps** — operator configurable seat layouts with standard, premium, wheelchair, and companion seats
- **Showings** — schedule movies on screens with automatic ticket generation from seat maps
- **Tickets** — auto-generated from seat maps with seat type tracking
- **Booking** — ticket booking endpoint with guard clauses and real-time seat count updates

## Tech Stack

- Ruby 3.3.4
- Rails 8.1.3
- PostgreSQL
- Ubuntu Server 24.04

## Models

## API Endpoints

### Movies

| Method | Endpoint    | Description     |
| ------ | ----------- | --------------- |
| GET    | /movies     | List all movies |
| POST   | /movies     | Create a movie  |
| GET    | /movies/:id | Get a movie     |
| PATCH  | /movies/:id | Update a movie  |
| DELETE | /movies/:id | Delete a movie  |

### Screens

| Method | Endpoint     | Description          |
| ------ | ------------ | -------------------- |
| GET    | /screens     | List all screens     |
| POST   | /screens     | Create a screen      |
| PATCH  | /screens/:id | Update a screen      |
| DELETE | /screens/:id | Soft delete a screen |

### Seat Maps

| Method | Endpoint              | Description                 |
| ------ | --------------------- | --------------------------- |
| GET    | /screens/:id/seat_map | Get seat map for a screen   |
| POST   | /screens/:id/seat_map | Create seat map             |
| PATCH  | /seats/:id            | Update individual seat type |

### Showings

| Method | Endpoint               | Description               |
| ------ | ---------------------- | ------------------------- |
| GET    | /movies/:id/screenings | List showings for a movie |
| POST   | /movies/:id/screenings | Schedule a showing        |
| DELETE | /screenings/:id        | Cancel a showing          |

### Tickets

| Method | Endpoint                | Description                |
| ------ | ----------------------- | -------------------------- |
| GET    | /screenings/:id/tickets | List tickets for a showing |
| POST   | /tickets/:id/book       | Book a ticket              |

## Setup

```bash
# Install Ruby 3.3.4 with rbenv
rbenv install 3.3.4
rbenv global 3.3.4

# Install dependencies
bundle install

# Set up database
rails db:create
rails db:migrate
rails db:seed

# Start server
rails server -b 0.0.0.0
```
