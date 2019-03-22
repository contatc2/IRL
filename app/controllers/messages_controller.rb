class MessagesController < ApplicationController
  def create
    # binding.pry
    @message = Message.new(message_params)
    @match = Match.find(params[:match_id])
    @message.match = @match
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.html { redirect to match_path(@match) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "match/show" }
        format.js
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
