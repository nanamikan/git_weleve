class ApplicationController < ActionController::Base
  
  before_action :authenticate_student!
  before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :メソッド名, if: :コントローラ名?
    
    
    
  include ErrorHandlers if Rails.env.productiion?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:grade])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:grade])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :preference,:grade,:intro,:avatar])
    # devise_parameter_sanitizer.permit(追加したいメソッドの種類, keys: [:パラメーター1, :パラメーター2,..])
  end
  
  
  def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
  end
  
  def after_sign_up_path_for(resource)
    new_student_session_path #新規登録後に遷移するpathを設定
  end
end
