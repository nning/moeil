Møil 
====

[![Build Status](https://img.shields.io/travis/nning/moeil.svg)](https://travis-ci.org/nning/moeil)
[![Code Climate](https://img.shields.io/codeclimate/github/nning/moeil.svg)](https://codeclimate.com/github/nning/moeil)
[![Coverage Status](https://img.shields.io/coveralls/nning/moeil.svg)](https://coveralls.io/r/nning/moeil)

**UNMAINTAINED, do not use**

Møil is an open source administration user interface for database backed mail
servers (postfix/dovecot). It brings the handy possibility of managing the
database with migrations and a lot of beautiful CRUD.

The code is available from [GitHub](https://github.com/nning/moeil.git).

Features
--------

* Tested with postfix and dovecot.
* Track database schema with rails migrations.
* Database agnostic (tested with SQLite3, PostgreSQL and MySQL/MariaDB).
* Managing domains, aliases and mailboxes.
* Permissions and Roles for Mailboxes to e.g. manage a certain domain.
* Responsive web user interface.
* Change log for review and reverting changes.
* Search (optionally based on SQL or elasticsearch).

Installation
------------

Just deploy like any other current rails project. Configuration examples for
postfix and dovecot are to be found in the doc directory of the code repository.

### Local testing

It is assumed, elasticsearch is installed and running. If you want to use SQL
based search, set `elasticsearch: false` in `config/settings.yml`.

    git clone git://github.com/nning/moeil.git
	cd moeil
	ln -s database.yml.example config/database.yml
	gem install bundler
	bundle
	rake secret:replace
	rake db:migrate
	rake db:seed
	rails s

### OpenShift

**(Note, that the OpenShift guide does currently not contain instructions for
elasticsearch.)**

First steps happen in your local terminal. So this is for creating an OpenShift
Ruby 1.9 application with a PostgreSQL 9.2 cartridge:

	rhc app create -a moeil -t ruby-1.9
	rhc cartridge add -a moeil -c postgresql-9.2

A git repository is created which holds your application code. We add the Møil
repository as a remote and pull the code to the application repository:

	cd moeil
	git remote add upstream -m master https://github.com/nning/moeil.git
	git pull -s recursive -X theirs upstream master

Then we push the current state and deploy the application (this will take some
time):

	git push origin master

To create a first domain and a mailbox, we have to SSH into the OpenShift
application and start a rails console:

	rhc ssh moeil
	cd app-root/repo
	RAILS_DB=postgresql RAILS_ENV=production bundle exec rails c

Then, inside the rails console, we are creating a domain and an associated
mailbox:

	d = Domain.create!(name: 'example.org')
	m = Mailbox.new(username: 'alice', password: 'foobar', admin: true)
	m.domain = d
	m.save!

Now you can login to your Møil deployment on OpenShift.

License
-------

Copyright © 2013-2015 [henning mueller](http://henning.orgizm.net/), released
under the terms of [GNU AGPL 3.0](http://www.gnu.org/licenses/agpl-3.0.html).
