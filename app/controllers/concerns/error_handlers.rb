module ErrorHandlers
  extend ActiveSupport::Concern
  
  included do
    rescue_from StandardError, with: :rescue500
    rescue_from Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    rescue_from ApplicationController::ActiveRecord::RecordNotFound, with: :rescue404
  end
  
  private def rescue403(e)
    @exception=e
    render "errors/forbidden", status: 403
  end
  
  private def rescue403(e)
    render "errors/not_found", status: 403
  end

  private def rescue500(e)
  # actionではなくファイル名を指定
    render "errors/internal_server_error", status: 500
  end
  
  
  
end