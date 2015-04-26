class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Callback
  before_action :require_login

  # Method
  private
  def not_authenticated
    redirect_to :root, notice: 'you are visitor to have access this resource must be authenticated'
  end

  def not_reseteable
    redirect_to :root, notice: 'reset link expired'
  end
end
