FROM docker.io/library/ruby:3.1.2

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Bundler and dependencies
RUN gem install bundler:2.3.6
RUN bundle install
RUN bundle exec rails db:create
RUN bundle exec rails db:migrate

# Copy the rest of the application code into the container
COPY . .

# Install Node.js dependencies
RUN apt-get update && apt-get install -y nodejs

# Expose the port on which the application will run
EXPOSE 3000

# Start the Rails application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
