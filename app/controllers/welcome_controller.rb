class WelcomeController < ApplicationController
  before_action :require_login, only: :home 

  def index
    key = 'AIzaSyDLYwW6jCVe15VBbsFFZhZ_INZNgol-oUs'
    user_ip = request.remote_ip
    redirect_to :Home if current_user
    if params[:search]
      if params[:search] != ''
        ebooks = Book.search('title', params[:search]).to_a
        gbooks = GoogleBooks.search(params[:search], {count: 30, api_key: key}, user_ip).to_a
        @books = (ebooks + gbooks).paginate(page: params[:page], per_page: 5)
      else
        @books = []
      end
    else
      @books = []
    end
  end

  def home
    key = 'AIzaSyDLYwW6jCVe15VBbsFFZhZ_INZNgol-oUs'
    user_ip = request.remote_ip
    @filters = ['no filter', 'partial', 'full', 'free-ebooks', 'paid-ebooks', 'ebooks']
    @keywords = ['no keyword', 'title', 'authors', 'publisher', 'isbn']
    if params[:search]
      if params[:search] != ''
        if params[:filtering] == 'no filter'
          if params[:keyword] == 'no keyword'
            ebooks = Book.search('title', params[:search]).to_a
            gbooks = GoogleBooks.search(params[:search], {count: 30, api_key: key}, user_ip).to_a
            @books = (ebooks + gbooks).paginate(page: params[:page], per_page: 5)
          else
            ebooks = Book.search(params[:keyword], params[:search]).to_a
            gbooks = GoogleBooks.search(params[:search], {count: 30, api_key: key}, user_ip).to_a
            @books = (ebooks + gbooks).paginate(page: params[:page], per_page: 5)
          end
        else
          if params[:keyword] == 'no keyword'
            if params[:filtering] == 'ebooks' or params[:filtering] == 'free-ebooks'
              ebooks = Book.search('title', params[:search]).to_a
              gbooks = GoogleBooks.search(params[:search], {filter: params[:filtering], count: 30, api_key: key}, user_ip).to_a
              @books = (ebooks + gbooks).paginate(page: params[:page], per_page: 5)
            else
              @books = GoogleBooks.search(params[:search], {filter: params[:filtering], count: 30, api_key: key}, user_ip).to_a.paginate(page: params[:page], per_page: 5)
            end
          else
            if params[:filtering] == 'ebooks' or params[:filtering] == 'free-ebooks'
              ebooks = Book.search(params[:keyword], params[:search]).to_a
              gbooks = GoogleBooks.search("#{params[:keyword]}:#{params[:search]}", {filter: params[:filtering], count: 30, api_key: key}, user_ip).to_a
              @books = (ebooks + gbooks).paginate(page: params[:page], per_page: 5)
            elsif params[:filtering] == nil
              ebooks = Book.search('title', params[:search]).to_a
              gbooks = GoogleBooks.search(params[:search], {count: 30, api_key: key}, user_ip).to_a
              @books = (ebooks + gbooks).paginate(page: params[:page], per_page: 5)
            else
              @books = GoogleBooks.search("#{params[:keyword]}:#{params[:search]}", {filter: params[:filtering], count: 30, api_key: key}, user_ip).to_a.paginate(page: params[:page], per_page: 5)
            end
          end
        end
      else
        @books = []
      end
    else
      @books = []
    end
  end
end