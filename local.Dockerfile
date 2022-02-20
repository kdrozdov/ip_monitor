FROM ruby:2.7.3-buster
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        ssh \
        libsodium23 \
        zsh \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN mkdir tmp && mkdir tmp/pids
RUN touch tmp/pids/puma.pid \
    && touch tmp/pids/puma.state
COPY privatekey ./
RUN mkdir -p /root/.ssh/ && \
    cp privatekey /root/.ssh/id_rsa && \
    chmod -R 600 /root/.ssh/ && \
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
COPY Gemfile* ./
RUN bundle install --jobs 20 --retry 5
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
