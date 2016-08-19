# Resque::Notifier

[![Code Climate](https://codeclimate.com/github/daveed/resque-notifier/badges/gpa.svg)](https://codeclimate.com/github/daveed/resque-notifier) [![Test Coverage](https://codeclimate.com/github/daveed/resque-notifier/badges/coverage.svg)](https://codeclimate.com/github/daveed/resque-notifier/coverage)

Resque Notifier is a Resque plugin that sends notifications when a job fails.

## Requirements

Ruby 2.3.1

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resque-notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resque-notifier

## Usage

### This gem activates a notifier when environment variables are set.

    example: Slack
    RESQUE_HOOK=https://hooks.slack.com/services/<generated_hash>
    RESQUE_CHANNEL="#channel-name"

### Add the Notifier backend to your existing Resque configuration (config/initializers/resque.rb)

```ruby
require 'resque/failure/notifier'
Resque::Failure::Multiple.classes = [Resque::Failure::Redis, Resque::Failure::Notifier]
Resque::Failure.backend = Resque::Failure::Multiple
```
    


## Contributing

1. Fork it ( https://github.com/[my-github-username]/resque-notifier/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
