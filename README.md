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
## Customization ##
### Status Codes ##
If you need to customize the status response codes simply edit the internationalization files in config/locales

### Params ###
To override the params string add this to an initializer file (or put it into config/initializers/short_message.rb)
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
