class FriendRequestsController < ApplicationController
  before_action :verify_user_friend_request, only: [:accept, :destroy]

  def index
    @friend_requests = current_user.incoming_friend_requests
  end
  
  def create
    friend_request = current_user.outgoing_friend_requests.build(requestee_id: params[:requestee_id])
    friend_request.save
  end

  def accept
    @friend_request = FriendRequest.find(params[:id])
    @friendship = current_user.friendships.build(friend: @friend_request.requester)

    if @friendship.save
      @friend_request.destroy
      flash[:notice] = 'Friend request accepted!'
      redirect_to friend_requests_path
    else
      redirect_to friend_requests_path
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy

    flash[:alert] = 'Friend request declined!'
    redirect_to friend_requests_path
  end

  private

  def verify_user_friend_request
    friend_request = FriendRequest.find(params[:id])

    unless current_user == friend_request.requestee
      flash[:alert] = 'You do not have the correct permissions to do this'
      redirect_to friend_requests_path
    end
  end
end
