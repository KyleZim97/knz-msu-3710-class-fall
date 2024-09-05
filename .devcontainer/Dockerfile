# Use the official Ruby image with version 3.2
FROM ruby:3.2

# Expose port 3000 for the Rails server
EXPOSE 3000

# Set up the working directory
WORKDIR /workspace

# Install Node.js, Yarn, and system dependencies
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update -qq && \
    apt-get install -y nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn build-essential libpq-dev sqlite3 libsqlite3-dev tzdata libvips && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Install Bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock before other files
# Utilizes Docker cache to speed up builds when gems do not change
COPY Gemfile Gemfile.lock ./

# Install application gems
RUN bundle install

# Copy the rest of the application code
COPY . /workspace


# Default command to start an interactive shell
CMD ["bash"]
