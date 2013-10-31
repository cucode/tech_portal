class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :process_auth_token

  DEFAULT_PAGE_LENGTH = 20


private

  def process_auth_token
    if params[:auth_token]
      user = User.find_by_authentication_token(params[:auth_token])
      return if user && (user == current_user)
      if user
        sign_in(user)
        flash[:success] = "You logged in."
      else
        flash[:error] = "Invalid token."
        render nothing: true, status: :unauthorized
      end
    end
  end
end
