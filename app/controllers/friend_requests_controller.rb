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

  def accept
    friend_request = FriendRequest.find(params[:id])
    if current_user == friend_request.requestee
      friendship = current_user.friendships.build(friend: friend_request.requester)
      friendship.save

      friend_request.destroy
    else
      redirect_to :index
    end
  end
end
