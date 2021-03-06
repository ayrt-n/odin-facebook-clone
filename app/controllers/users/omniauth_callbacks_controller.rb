class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :github

  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      session['devise.github_data'] = request.env['omniauth.auth'].except(:extra)
      errors = @user.errors.full_messages.to_sentence.downcase
      flash[:alert] = "Could not authenticate you from Github because #{errors}" if is_navigational_format?
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end