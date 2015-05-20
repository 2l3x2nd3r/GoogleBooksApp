class BooksController < ApplicationController
  skip_before_action :require_login, only: [:show]
  before_filter :require_login, only: [:edit, :update, :new, :create, :destroy]
  before_action :get_user, only: [:new, :create]
  before_action :get_book, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @book = @user.books.new
  end

  def edit
  end

  def update
    @book.assign_attributes(book_params)
    if @book.save
      redirect_to "/users/#{current_user.username}", notice: 'El libro ha sido actualizado'
    else
      render :edit
    end
  end

  def create
    @book = @user.books.new(book_params)
    if @book.save
      redirect_to :root, notice: 'El libro ha sido creado'
    else
      flash[:error] = 'No se ha podido crear el libro'
      render :new
    end
  end

  def destroy
    @book.destroy
    redirect_to :root
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def book_params
    params.require(:book).permit(:image, :pdf, :title, :authors, :description, :categories, :isbn, :publisher, :published_date)
  end

  def get_book
    get_user
    @book = Book.find(params[:id])
  end
end