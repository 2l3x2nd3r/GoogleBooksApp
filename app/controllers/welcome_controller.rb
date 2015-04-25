class WelcomeController < ApplicationController

  def index
    key = 'AIzaSyDLYwW6jCVe15VBbsFFZhZ_INZNgol-oUs'
    @filters = ['no filter', 'partial', 'full', 'free-ebooks', 'paid-ebooks', 'ebooks']
    @keywords = ['no keyword', 'intitle', 'inauthor', 'inpublisher', 'subject', 'isbn']
    if params[:search]
      if params[:filtering] == 'no filter'
        if params[:keyword] == 'no keyword'
          @books = GoogleBooks.search(params[:search], {count: 15, api_key: key}) 
        else
          @books = GoogleBooks.search("#{params[:keyword]}:#{params[:search]}", {count: 15, api_key: key})
        end
      else
        if params[:keyword] != 'no keyword'
          @books = GoogleBooks.search("#{params[:keyword]}:#{params[:search]}", {filter: params[:filtering], count: 15, api_key: key})
        else
          @books = GoogleBooks.search(params[:search], {filter: params[:filtering], count: 15, api_key: key})
        end
      end
    else
      @books = []
    end
  end

end
