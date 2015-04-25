class BooksController < ApplicationController
  def show
    key = 'AIzaSyDLYwW6jCVe15VBbsFFZhZ_INZNgol-oUs'
    if params[:isbn]
      @book = GoogleBooks.search("isbn:#{params[:isbn]}", {count: 15, api_key: key}).first
    else
      @book = GoogleBooks.search("intitle:#{params[:title]}", {count: 15, api_key: key}).first
    end
  end
end
