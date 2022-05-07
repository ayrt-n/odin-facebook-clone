class FriendRequestsController < ApplicationController
  def index
    @friend_requests = current_user.incoming_friend_requests
  end
  
  def create
    friend_request = current_user.outgoing_friend_requests.build(requestee_id: params[:requestee_id])
    friend_request.save
  end

  def destroy

  end
end
