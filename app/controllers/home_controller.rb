class HomeController < ApplicationController
  def show
  end

  def send_message
  	@message = Message.new(message_params)
  	ContactMailer.contact_us(@message).deliver

  	respond_to do |format|
  		format.js
  	end
  end

  private

    def message_params
      params.require(:message).permit(:name, :email, :subject, :content)
    end

end
