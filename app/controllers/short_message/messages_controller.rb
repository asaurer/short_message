require_dependency "short_message/application_controller"

module ShortMessage
  class MessagesController < ApplicationController
    def status
      unless params[:id].blank? or params[:status].blank?
        if message = ShortMessage::Message.find_by(message_key: params[:id])
          message.status_code = params[:status]
          message.save!

          render plain: "Message #{params[:id]} has now status #{params[:status]}"
        else
          render plain: "Message #{params[:id]} not found!", status: 404
        end
      else
        render plain: "Message ID or status not provided!", status: 400
      end
    end
  end
end
