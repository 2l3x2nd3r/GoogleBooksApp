class PasswordResetsController < ApplicationController
  
  skip_before_action :require_login 

  def new
  end
  
  def create
    @user.deliver_reset_password_instructions! if @user = User.find_by_email(params[:email])
    redirect_to root_path, notice: 'Intrucciones enviadas a tu correo'
  end

  def edit
    not_reseteable unless @user = User.load_from_reset_password_token(params[:id])
  end

  def update
    @user = User.load_from_reset_password_token(params[:id])
    @user.assign_attributes(password_confirmation: params[:user][:password_confirmation])
    if @user.change_password!(params[:user][:password]) 
      redirect_to :root, notice: 'Contraseña Restaurada'
    else
      render :edit
    end
  end
end
