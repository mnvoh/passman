FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN mkdir /passman
WORKDIR /passman
COPY Gemfile /passman/Gemfile
COPY Gemfile.lock /passman/Gemfile.lock
COPY package.json /passman/package.json
COPY package-lock.json /passman/package-lock.json
RUN bundle install
RUN npm install
