require_dependency "short_message/application_controller"

module ShortMessage
  class MessagesController < ApplicationController
    def status
      unless params[:id].blank? or params[:status].blank?
        if message = ShortMessage::Message.where(message_key: params[:id]).first
          message.status_code = params[:status]
          message.save!

          ActiveSupport::Notifications.instrument('short_message.status_updated', options: { key: params[:id], status: params[:status] })
          message = "Message #{params[:id]} has now status #{params[:status]}"
        else
          message = "Message #{params[:id]} not found!"
          status = 404
        end
      else
        message = "Message ID or status not provided!"
        status = 400
      end

      if Rails.version[0].to_i > 4
        render plain: message, status: status
      else
        render text: message, status: status
      end
    end
  end
end
