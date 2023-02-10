FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y postgresql-client

# freeze the bundle config which will actually help us maintain consistency over the dockerized system and host system
RUN bundle config --global frozen 1

# working directory inside the docker system
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .
RUN chmod +x entrypoint.sh
#ENTRYPOINT ["./entrypoint.sh"]

# expose port 3000
EXPOSE 3000

# start the rails server binding it to 0.0.0.0
CMD ["rails", "server", "-b", "0.0.0.0"]