class OmniauthController < Devise::OmniauthCallbacksController

  def linkedin
    omniauth = env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    else
      user = User.find_by_email(omniauth['info']['email']) || User.new(email: omniauth['info']['email'], password: Devise.friendly_token[0,20])
      user.authentications.build(provider: omniauth['provider'], uid: omniauth['uid'])
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        render text: omniauth['info']['email'].to_yaml
      end
    end
  end
  
end
