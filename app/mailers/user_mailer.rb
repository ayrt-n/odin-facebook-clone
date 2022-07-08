class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @login_url = new_user_session_url

    attachments.inline['email_header.png'] = File.read("#{Rails.root}/app/assets/images/email_header.png")
    attachments.inline['left_buddy.png'] = File.read("#{Rails.root}/app/assets/images/left_buddy.png")
    attachments.inline['right_buddy.png'] = File.read("#{Rails.root}/app/assets/images/right_buddy.png")

    @url = root_url

    mail(to: @user.email, subject: 'Welcome to FaceBuddies!')
  end
end
