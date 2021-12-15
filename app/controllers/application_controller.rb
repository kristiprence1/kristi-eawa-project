class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # # rescue from cancancan error
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  helper_method :admin?

  def admin?
    current_user.role.name == "admin"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :contact_address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname, :contact_address])
  end
end
