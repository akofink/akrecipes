## akRecipes ##

[![Build Status](https://travis-ci.org/akofink/recipes.svg?branch=master)](https://travis-ci.org/akofink/recipes)
[![Code Climate](https://codeclimate.com/github/akofink/recipes.png)](https://codeclimate.com/github/akofink/recipes)
[![Coverage Status](https://coveralls.io/repos/akofink/recipes/badge.png)](https://coveralls.io/r/akofink/recipes)

This is an open source recipes web site. I currently run it in production at http://recipes.akofink.com.

### To Install

Installation is performed in four steps:

1. Clone from Git
1. Build Dependencies
1. Set Up Database
1. Start the Server

#### Clone from Git

```sh
git clone https://github.com/akofink/akrecipes.git
cd akrecipes
```

#### Build Dependencies

Install ruby 2.1 ([rbenv](https://github.com/sstephenson/rbenv) or [rvm](https://rvm.io/))

```sh
gem install bundler
bundle install
```

#### Set Up Database

Use [postgresql](http://www.postgresql.org/download/).
On OS X, I use [Postgres.app](http://postgresapp.com/).

Set up database user:
```SQL
create user rails superuser;
```

From the shell:
```sh
cp config/database.yml.example config/database.yml
bundle exec rake db:drop db:setup db:test:prepare
```
#### Start the  Server

```sh
rails server
```

Now visit [http://localhost:3000](http://localhost:3000)


### Markdown Parsing
- [Emoji cheat sheet](http://www.emoji-cheat-sheet.com/)
- [Markdown cheat sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
