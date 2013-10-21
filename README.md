[![Build Status](https://travis-ci.org/nning/moeil.png?branch=master)](https://travis-ci.org/nning/moeil)
[![Code Climate](https://codeclimate.com/github/nning/moeil.png)](https://codeclimate.com/github/nning/moeil)

Møil 
====

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

Installation
------------

Just deploy like any other current rails project. Configuration examples for
postfix and dovecot are to be found in the doc directory of the code repository.

### For Testing

    git clone git://github.com/nning/moeil.git
	cd moeil
	ln -s database.yml.example config/database.yml
	gem install bundler
	bundle
	rake secret:replace
	rake db:migrate
	rake db:seed
	rails s

License
-------

Copyright © 2013 [henning mueller](http://henning.orgizm.net/), released under
the terms of [GNU AGPL 3.0](http://www.gnu.org/licenses/agpl-3.0.html).
