# ApiEvents

This gem is a solution to send messages between multiple web applications without relying on other services like redis.

Given messages are sent as HTTP requests (to keep things simple) it won't have an excellent performance as it would with a message queue service. However, given this keeps the infrastructure simpler than with a message queue service,
it's useful for WebApps where broadcasting message is not the primary need, but a side feature used eventually.

# How it works?

Basically, when you install this gem you will get an endpoint `/api/events` where you will be able to receive notifications. You will need to create a class for each expected event, to build the behaviour of what you want to happen when that even is received.

For example, lets say you have two applications: `App1` and `App2`. `App1` has a model called `Invoice`, and `App2` wants to know when an invoice is created on `App1`.
Both apps needs to have the gem installed.

For this example, `App1` will broadcast the event after the invoice was created. `App2` will receive the message, and react to that.

First we need to specify on `App1` the url of the apps that will receive the message:

```ruby
# config/initializers/api_events.rb

ApiEvents.configure do |config|
  # you should take the urls from the secrets.yml in order to have different urls between your development and production apps.
  config.listeners = ["http://localhost:3000/"]
end
```

Then we create a class on `App2` which will be executed when the event is received.

```ruby
# App2/events/invoice_created.rb

class Events::InvoiceCreated < ApiEvents::Base
  listen_to :invoice_created

  def perform(payload)
    puts "Invoice with id #{payload[:id]} was created!"
  end
end
```

And finally, on our model in `App1` we ask to broadcast events when a new record is created.

```ruby
# App1/models/invoice.rb

class Invoice < ApplicationRecord
  broadcast_on :created
end
```

That's it! Now when an `Invoice` is created on `App1`, a request will be triggered to the `App2` endpoint to let it know an invoice was created, and the event class we created will perform.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'api_events'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_events

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/api_events. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ApiEvents project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/api_events/blob/master/CODE_OF_CONDUCT.md).
