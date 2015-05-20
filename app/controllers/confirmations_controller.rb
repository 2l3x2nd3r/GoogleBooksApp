class ConfirmationsController < ApplicationController
  skip_before_action :require_login

  def show
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to '/login', notice: 'Tu cuenta ha sido activada, Bienvenido'   
    else 
      redirect_to :root, error: 'Token Invalido'
    end
  end
end
