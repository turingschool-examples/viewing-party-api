# Viewing Part API - Solo Project

This is the base repo for the Viewing Party Solo Project for Module 3 in Turing's Software Engineering Program. 

## About this Application

Viewing Party is an application that allows users to explore movies and create a Viewing Party Event that invites users and keeps track of a host. Once completed, this application will collect relevant information about movies from an external API, provide CRUD functionality for creating a Viewing Party and restrict its use to only verified users. 

## Setup

1. Fork and clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`

Spend some time familiarizing yourself with the functionality and structure of the application so far.

Run the application and test out some endpoints: `rails s`

## Endpoints
BASE URL: `http://localhost:3000`

### Get Users 

REQUEST

``` GET /api/v1/users ```

RESPONSE

```
{
    "data": [
        {
            "id": "1",
            "type": "user",
            "attributes": {
                "name": "Danny DeVito",
                "username": "danny_de_v"
            }
        },
        {
            "id": "2",
            "type": "user",
            "attributes": {
                "name": "Dolly Parton",
                "username": "dollyP"
            }
        },
        {
            "id": "3",
            "type": "user",
            "attributes": {
                "name": "Lionel Messi",
                "username": "futbol_geek"
            }
        }
    ]
}
```

### Top Rated Movies 

REQUEST

```GET /api/v1/movies/top_rated ```

RESPONSE

```
{
    "data": [
        {
            "id": "278",
            "type": "movie",
            "attributes": {
                "title": "The Shawshank Redemption",
                "vote_average": 8.708
            }
        },
        {
            "id": "238",
            "type": "movie",
            "attributes": {
                "title": "The Godfather",
                "vote_average": 8.689
            }
        },
        {
            "id": "240",
            "type": "movie",
            "attributes": {
                "title": "The Godfather Part II",
                "vote_average": 8.6
            }
        },
        ...,
        ...,
    ]
}

```

### Movie Search

REQUEST

```GET /api/v1/movies?search=Lord of the Rings```

RESPONSE

```
{
    "data": [
        {
            "id": "839033",
            "type": "movie",
            "attributes": {
                "title": "The Lord of the Rings: The War of the Rohirrim",
                "vote_average": 6.6
            }
        },
        {
            "id": "122",
            "type": "movie",
            "attributes": {
                "title": "The Lord of the Rings: The Return of the King",
                "vote_average": 8.484
            }
        },
        {
            "id": "120",
            "type": "movie",
            "attributes": {
                "title": "The Lord of the Rings: The Fellowship of the Ring",
                "vote_average": 8.4
            }
        },
        ...,
        ...,
    ]
}
```

### Create Viewing Party

REQUEST

```POST /api/v1/viewing_parties```

REQUEST BODY

```
{ 
  "host_id": 3,
  "name": "Juliet's Bday Movie Bash!",
  "start_time": "2025-02-01 10:00:00",
  "end_time": "2025-02-01 14:30:00",
  "movie_id": 278,
  "movie_title": "The Shawshank Redemption",
  "invitees": [2, 1]
}
```

RESPONSE

```
{
    "data": {
        "id": "10",
        "type": "viewing_party",
        "attributes": {
            "hosts_user_id": 3,
            "name": "Juliet's Bday Movie Bash!",
            "start_time": "2025-02-01T10:00:00.000Z",
            "end_time": "2025-02-01T14:30:00.000Z",
            "movie_id": 278,
            "movie_title": "The Shawshank Redemption",
            "invitees": [
                {
                    "id": 1,
                    "name": "Danny DeVito",
                    "username": "danny_de_v"
                },
                {
                    "id": 2,
                    "name": "Dolly Parton",
                    "username": "dollyP"
                }
            ]
        }
    }
}
```
