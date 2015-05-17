class SessionsController < ApplicationController
  
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      redirect_to :Home, notice: 'Logged in,  Welcome'
    else
      flash.now[:error] = 'login failed, please try again'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to :root, notice: 'logged out'
  end
end
