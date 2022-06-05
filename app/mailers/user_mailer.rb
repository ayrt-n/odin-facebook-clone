class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @login_url = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to FaceBuddies!')
  end
end
