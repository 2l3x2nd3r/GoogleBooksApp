class BooksController < ApplicationController
  skip_before_action :require_login, only: [:show]
  before_action :get_book, only: [:show, :edit, :update]
  before_filter :require_login, only: [:edit, :update, :new, :create, :destroy]

  def show
    @book = Book.find(1)
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def update
    @book.assign_attributes(book_params)
    if @book.save
      redirect_to "/users/#{current_user.username}"
    else
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
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

  def book_params
    params.require(:book).permit(:image, :pdf, :title, :authors, :description, :categories, :isbn, :publisher, :published_date)
  end

  def get_book
    
  end
end
