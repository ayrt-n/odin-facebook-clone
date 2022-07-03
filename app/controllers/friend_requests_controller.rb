class FriendRequestsController < ApplicationController
  before_action :verify_user_friend_request, only: %i[accept decline]

  def index
    @incoming_friend_requests = current_user.incoming_friend_requests
                                            .includes({ requester: [{ avatar_attachment: :blob }] })
    @outgoing_friend_requests = current_user.outgoing_friend_requests
                                            .includes({ requestee: [{ avatar_attachment: :blob }] })
  end

  def create
    @friend_request = current_user.outgoing_friend_requests.build(requestee_id: params[:requestee_id])

    flash[:alert] = 'Ahh, something went wrong! We could not send a new friend request' unless @friend_request.save

    redirect_back(fallback_location: root_path)
  end

  def accept
    @friend_request = FriendRequest.find(params[:id])

    if @friend_request.update(accepted: true)
      flash[:notice] = 'Friend request accepted!'
    else
      flash[:alert] = 'Ahh, something went wrong! Friend request could not be accepted'
    end

    redirect_to friend_requests_path
  end

  def decline
    @friend_request = FriendRequest.find(params[:id])

    flash[:alert] = if @friend_request.destroy
                      'Friend request declined!'
                    else
                      'Ahh, something went wrong! Friend request could not be accepted'
                    end

    redirect_to friend_requests_path
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def verify_user_friend_request
    friend_request = FriendRequest.find(params[:id])
    return if current_user == friend_request.requestee

    flash[:alert] = 'You do not have the correct permissions to do this'
    redirect_back(fallback_location: root_path)
  end
end
