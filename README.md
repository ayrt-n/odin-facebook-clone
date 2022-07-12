# Ruby on Rails Facebook Clone 

## Table of Contents
- [Overview](#overview)
- [Set Up](#set-up)
   - [Using Web Browser](#using-web-browser) * RECOMMENDED *
   - [Using Local Machine](#using-local-machine)
- [Database Structure](#database-structure)
- [Thoughts and Takeaways](#thoughts-and-takeaways)

## Overview

Final project for the Ruby on Rails section of The Odin Project (https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project). 

The goal of the project was to rebuild a large portion of the core Facebook functionality. The basic requirements included:
- Users must sign in to see anything except for the sign in page
- Users can send Friend Requests to other users
- Users must accept the Friend Request to become friends
- Friend requests appear in the notifications section of the User's navbar
- Users can create Posts
- Users can Like Posts
- Facebook timeline feature which displays all recent Posts from the current User and friends
- Posts display Post content, author, Comments, and Likes
- User show page contains profile information, photo, and Posts
- User index page lists all Users which are not friends of the current User and buttons for sending Friend Requests

## Set Up
### Using Web Browser
The easiest way to view and test out the app is online at: facebuddies.herokuapp.com

### Using Local Machine
If you would like to run the web app on your local machine you will first need to install [Ruby](https://guides.rubyonrails.org/v5.0/getting_started.html), [Rails](https://guides.rubyonrails.org/v5.0/getting_started.html), and [PostgreSQL](https://medium.com/geekculture/postgresql-rails-and-macos-16248ddcc8ba).

Once you have Ruby on Rails and PostgreSQL set up, clone the repo into a fresh directory and run:

```bundle install```

To install all of the gem dependencies for the project.

After the gem dependencies have been installed, you may create, migrate, and seed the database with the default schema and some example records by running:

```rails db:create db:migrate db:seed```

Once the database has been set up, you should be able to access the web application by starting up a server using:

```rails s```

And opening a browser and navigating to:

```http://localhost:3000/```

## Database Structure



## Thoughts and Takeaways


