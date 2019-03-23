class MatchesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "match_#{params[:match_id]}"
  end

  # def unsubscribed
  #   Any cleanup needed when channel is unsubscribed
  # end
end
