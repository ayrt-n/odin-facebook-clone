class FriendRequestsController < ApplicationController
  before_action :verify_user_friend_request, only: [:accept, :decline]

  def index
    @incoming_friend_requests = current_user.incoming_friend_requests
                                            .includes({ requester: [{ avatar_attachment: :blob }] })
    @outgoing_friend_requests = current_user.outgoing_friend_requests
                                            .includes({ requestee: [{ avatar_attachment: :blob }] })
  end

  def create
    @friend_request = current_user.outgoing_friend_requests.build(requestee_id: params[:requestee_id])

    if @friend_request.save
      redirect_to users_path
    else
      flash[:alert] = 'Ahh, something went wrong! We could not send a new friend request'
      redirect_to users_path
    end
  end

  def accept
    @friend_request = FriendRequest.find(params[:id])

    flash[:notice] = 'Friend request accepted!' if @friend_request.update(accepted: true)
    redirect_to friend_requests_path
  end

  def decline
    @friend_request = FriendRequest.find(params[:id])

    flash[:alert] = 'Friend request declined!' if @friend_request.destroy
    redirect_to friend_requests_path
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy

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
