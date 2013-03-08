# ShortMessage #
## Installation ##

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

And rake the migrations:
```console
rake db:migrate
```
## Usage ##

Create a message and deliver it:
```ruby
@sms = ShortMessage::Message.new(:sender => "0041791234567", :recipient => "0041799876543", :text => "Hello World!")
@sms.deliver
```
