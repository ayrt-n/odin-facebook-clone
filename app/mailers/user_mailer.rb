class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  layout 'layouts/mailer'

  def welcome_email
    @user = params[:user]
    @home_url = root_url

    attachments.inline['email_header.png'] = File.read("#{Rails.root}/app/assets/images/email_header.png")
    attachments.inline['left_buddy.png'] = File.read("#{Rails.root}/app/assets/images/left_buddy.png")
    attachments.inline['right_buddy.png'] = File.read("#{Rails.root}/app/assets/images/right_buddy.png")

    mail(to: @user.email, subject: 'Welcome to FaceBuddies!')
  end
end
