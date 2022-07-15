class CustomDeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
  default from: 'ayrton.parkinson1@gmail.com'
  layout 'layouts/mailer'

  def reset_password_instructions(record, token, opts={})
    attachments.inline['email_header.png'] = File.read("#{Rails.root}/app/assets/images/email_header.png")
    attachments.inline['left_buddy.png'] = File.read("#{Rails.root}/app/assets/images/left_buddy.png")
    attachments.inline['right_buddy.png'] = File.read("#{Rails.root}/app/assets/images/right_buddy.png")
    super
  end
end