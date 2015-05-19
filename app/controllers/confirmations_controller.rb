class ConfirmationsController < ApplicationController
  skip_before_action :require_login

  def show
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      auto_login(@user)
      redirect_to :root, notice: 'Tu cuenta ha diso activada, Bienvenido'   
    else 
      redirect_to :root, error: 'Token Invalido'
    end
  end
end
