FROM ruby:3.0.0

RUN apt-get update -yqq

ADD . /shatit
WORKDIR /shatit
COPY Gemfile /shatit/Gemfile
COPY Gemfile.lock /shatit/Gemfile.lock
RUN bundle config set force_ruby_platform true
RUN bundle update
RUN bundle install
RUN gem install redis
RUN gem install mailcatcher

EXPOSE 5005

CMD ["rails", "s", "-b", "0.0.0.0"]
