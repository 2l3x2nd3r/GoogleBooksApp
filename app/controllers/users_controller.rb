class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :root, notice: 'your proccess of singup is almost complete redirect to email to activate'
    else
      flash[:error] = 'your proccess singup can\'t complete'
      render :new
    end
  end

  def destroy
    current_user.destroy
    logout
    redirect_to :root, notice: 'Logout!!!'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
