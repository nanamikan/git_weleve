class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_student!
  before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :メソッド名, if: :コントローラ名?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:grade])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:grade])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :preference,:grade,:intro,:image])
    # devise_parameter_sanitizer.permit(追加したいメソッドの種類, keys: [:パラメーター1, :パラメーター2,..])
  end
  
  
  def after_sign_in_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
  end
  
  def after_sign_up_path_for(resource)
    root_path # ログイン後に遷移するpathを設定
  end
  
 
end
