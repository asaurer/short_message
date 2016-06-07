# ShortMessage

[![Gem Version](https://badge.fury.io/rb/short_message.png)](http://badge.fury.io/rb/short_message)

## Installation

Add it to your Gemfile:

```ruby
gem 'short_message'
```

Run the following command to install it:

```console
bundle install
```

Run the generator:

```console
rails generate short_message:install
```

And run the migrations:

```console
rake db:migrate
```

## Usage

Create a message and deliver it:

```ruby
@sms = ShortMessage::Message.new(sender: "0041791234567", recipient: "0041799876543", text: "Hello World!")
@sms.deliver
```

## Delivery Report

ShortMessage listens for status updates on `/short_message/messages/status`. Provide `:id` and `:status` by either `POST` or `GET`.

## Customization

### Status Codes

If you need to customize the status response codes simply edit the internationalization files in config/locales

### Params

To override the params string add the code below into `config/initializers/short_message.rb`:

```ruby
ShortMessage::Message.module_eval do
  private
  def build_deliver_params_string
    # your code here
  end

  def build_recharge_params_string amount
    # your code here
  end
end
```

### Events

ShortMessage sends event notifications on message delivery `short_message.delivered` and on status update `short_message.status_updated`. Add following code to an initializer to listen:

```ruby
ActiveSupport::Notifications.subscribe('short_message.status_updated') do |name, start, finish, id, payload|
  Activity.create(successful: true, message: "Message #{payload[:options][:key]} has now status #{payload[:options][:status]}.")
end
```
