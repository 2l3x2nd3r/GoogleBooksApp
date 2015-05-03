class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :get_user, only: [:show, :edit, :update]
  before_filter :require_login, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params_update)
      flash[:success] = "Profile updated."
      redirect_to :root
    else
      render 'edit'
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
    logout
    redirect_to :root, notice: 'Logout!!!'
  end

  private

  def correct_user
    get_user
    redirect_to(:root) unless current_user == @user
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def user_params_update
    params.require(:user).permit(:username, :firstname, :lastname, :biography, :location)
  end

  def get_user
    @user = User.find_by_username(params[:id])
  end
end
