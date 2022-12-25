class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:last_name,:first_name,:last_name_kana,:first_name_kana,:postcode,:address,:phone_number,:is_customer_deleted])
  end
end
