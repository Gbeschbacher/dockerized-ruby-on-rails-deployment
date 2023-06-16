FROM ruby:3.2.2-bullseye
ARG PORT=3000

WORKDIR /usr/src/app
COPY . .
RUN bundle install

EXPOSE ${PORT}
ENV PATH="/usr/src/app/bin:${PATH}"
CMD ["rails", "server", "-b", "0.0.0.0"]
