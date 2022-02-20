FROM ruby:2.7.3-buster
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        ssh \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN mkdir tmp && mkdir tmp/pids
RUN touch tmp/pids/puma.pid \
    && touch tmp/pids/puma.state
COPY Gemfile* ./
RUN bundle install --jobs 20 --retry 5 --without development test
COPY . ./
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
