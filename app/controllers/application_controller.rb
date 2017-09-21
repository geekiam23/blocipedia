class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :authenticate_user!, only: [:index]
  include Pundit


  protected
  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    #   user_params.permit(:username, :email)
    additional_params = [:name, :company, :email_confirmation,   {addresses_attributes: [:address1, :address2, :city, :state, :zip, :country, :name]}]
    devise_parameter_sanitizer.permit(:sign_up, keys: additional_params)
    devise_parameter_sanitizer.permit(:account_update, keys: additional_params)
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
end
