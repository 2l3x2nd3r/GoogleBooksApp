class ConfirmationsController < ApplicationController
  skip_before_action :require_login

  def show
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      if auto_login(@user)
        redirect_to :Home, notice: 'Bienvenido'
      else
        redirect_to :root, notice: 'Tu cuenta ha diso activada, puedes iniciar sesión'
      end    
    else 
      redirect_to :root, error: 'Token Invalido'
    end
  end
end
