class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :gender, :birthday, :address, :rut, :phone_number, :health_system, :afp, :emergency_number])
    devise_parameter_sanitizer.permit(:account_update, keys:[:name, :gender, :birthday, :address, :rut, :phone_number, :health_system, :afp, :emergency_number, :current_password, :email, :password, :password_confirmation])
  end
end
