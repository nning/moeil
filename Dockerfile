FROM ruby:2.3.4

ADD . /moeil
WORKDIR /moeil

RUN \
	ln -sf database.yml.example config/database.yml && \
	bundle && \
	rake db:migrate

CMD \
	rake
