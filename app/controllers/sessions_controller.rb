class SessionsController < ApplicationController
  
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      redirect_to :Home, notice: 'Bienvenido'
    else
      redirect_to '/login', notice: 'Usuario, Email o Contraseña Equivocado, intente de nuevo'
    end
  end

  def destroy
    logout
    redirect_to :root
  end
end
