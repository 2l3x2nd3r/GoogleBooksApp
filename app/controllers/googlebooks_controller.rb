class GooglebooksController < ApplicationController
  skip_before_action :require_login
  
  def show
    key = 'AIzaSyDLYwW6jCVe15VBbsFFZhZ_INZNgol-oUs'
    user_ip = request.remote_ip
    if params[:isbn]
      @book = GoogleBooks.search("isbn:#{params[:isbn]}", {count: 15, api_key: key}, user_ip).first
    else
      @book = GoogleBooks.search("intitle:#{params[:title]}", {count: 15, api_key: key}, user_ip).first
    end
  end
end
