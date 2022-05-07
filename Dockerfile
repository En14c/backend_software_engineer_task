FROM ruby:3.0.2

ARG USER_ID
ARG GROUP_ID

WORKDIR /pennylanetask

RUN addgroup --gid $GROUP_ID pennylaneuser
RUN adduser --disabled-password --gecos "" --uid $USER_ID --gid $GROUP_ID pennylaneuser

RUN gem install bundler
COPY ./Gemfile /pennylanetask/Gemfile
COPY ./Gemfile.lock /pennylanetask//Gemfile.lock
RUN bundle install

COPY . /pennylanetask/

RUN chown -R pennylaneuser:pennylaneuser /pennylanetask

USER $USER_ID