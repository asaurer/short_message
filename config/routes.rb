Rails.application.routes.draw do
  namespace :short_message do
    get 'messages/status' => "messages#status"
    post 'messages/status' => "messages#status"
  end
end
