# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :short_message_message, :class => 'Message' do
    message_key "MyString"
    sender "MyString"
    recipient "MyString"
    status_code 1
    text "MyText"
  end
end

FactoryGirl.define do
  factory :message, class: ShortMessage::Message do
    
  end
end
