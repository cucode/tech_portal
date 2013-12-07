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

  rescue_from ::CanCan::Error do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    if user_signed_in?
      flash[:error] = "Not authorized to view this page."
      session[:user_return_to] = nil
      redirect_to root_url
    else
      flash[:error] = "You must log in to view this page."
      session[:user_return_to] = request.url
      redirect_to root_path
    end
  end
end
