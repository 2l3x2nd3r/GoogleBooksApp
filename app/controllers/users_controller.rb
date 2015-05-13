class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :get_user, only: [:show, :edit, :update]
  before_filter :require_login, :only => [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    current_user.assign_attributes(update_user_params)
    if current_user.save
      redirect_to "/users/#{current_user.username}"
    else
      render :edit
    end
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
    logout unless destroyed?
    redirect_to :root, notice: 'Logout!!!'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:username, :email, :firstname, :lastname, :biography, :location, :password, :password_confirmation)
  end

  def get_user
    @user = User.find_by_username(params[:id])
  end
end
