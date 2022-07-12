# Ruby on Rails Facebook Clone 

## Table of Contents
- [Overview](#overview)
- [Set Up](#set-up)
   - [Using Web Browser](#using-web-browser) * RECOMMENDED *
   - [Using Local Machine](#using-local-machine)
- [Database Structure](#database-structure)
- [Thoughts and Takeaways](#thoughts-and-takeaways)

## Overview

Final project for the Ruby on Rails section of The Odin Project (https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project) to create a "Facebook clone" using Ruby on Rails. 

## Set Up
### Using Web Browser
The easiest way to view and test out the app is online at: facebuddies.heroku.com

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

Capstone project from The Odin Project, providing the opportunity to implement everything learned through the Ruby section of the curriculum (e.g., working with basic data types, OOP and design, serialization, testing and TDD).

Beyond the technical aspects, this project provided the opportunity to get experience working with and solving a broadly scoped problem (final project did not provide any details on implementation). As such, I was required to think through the problem and implementation, maintain a disciplined workflow (utilizing git to safely experiment), stay organized, and break the problem down into workable components.
