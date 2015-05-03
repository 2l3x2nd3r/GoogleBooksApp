class WelcomeController < ApplicationController
  
  skip_before_action :require_login 

  def index
    key = 'AIzaSyDLYwW6jCVe15VBbsFFZhZ_INZNgol-oUs'
    user_ip = request.remote_ip
    @filters = ['no filter', 'partial', 'full', 'free-ebooks', 'paid-ebooks', 'ebooks']
    @keywords = ['no keyword', 'intitle', 'inauthor', 'inpublisher', 'subject', 'isbn']
    if params[:search]
      if params[:filtering] == 'no filter'
        if params[:keyword] == 'no keyword'
          @books = GoogleBooks.search(params[:search], {count: 30, api_key: key}, user_ip).to_a.paginate(page: params[:page], per_page: 5)
        else
          @books = GoogleBooks.search("#{params[:keyword]}:#{params[:search]}", {count: 30, api_key: key}, user_ip).to_a.paginate(page: params[:page], per_page: 5) 
        end
      else
        if params[:keyword] != 'no keyword'
          @books = GoogleBooks.search("#{params[:keyword]}:#{params[:search]}", {filter: params[:filtering], count: 30, api_key: key}, user_ip).to_a.paginate(page: params[:page], per_page: 5) 
        else
          @books = GoogleBooks.search(params[:search], {filter: params[:filtering], count: 30, api_key: key}, user_ip).to_a.paginate(page: params[:page], per_page: 5) 
        end
      end
    else
      @books = []
    end
  end
end