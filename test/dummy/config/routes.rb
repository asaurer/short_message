Rails.application.routes.draw do

  mount ShortMessage::Engine => "/short_message"
end
