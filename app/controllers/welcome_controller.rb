class WelcomeController < ApplicationController
  
  skip_before_action :require_login 

  def index
    key = 'AIzaSyDLYwW6jCVe15VBbsFFZhZ_INZNgol-oUs'
    amazon_configuration
    user_ip = request.remote_ip
    @filters = ['no filter', 'partial', 'full', 'free-ebooks', 'paid-ebooks', 'ebooks']
    @keywords = ['no keyword', 'intitle', 'inauthor', 'inpublisher', 'subject', 'isbn']
    if params[:search]
      if params[:filtering] == 'no filter'
        if params[:keyword] == 'no keyword'
          # @books = Amazon::Ecs.item_search(params[:search], {search_index: 'All'}).items
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

  private

  def amazon_configuration
    Amazon::Ecs.options = {
      version: "2013-08-01",
      service: "AWSECommerceService",
      associate_tag: 'laconchaetutia',
      AWS_access_key_id: 'AKIAINLAVDGVT4KKUPMA',
      AWS_secret_key: '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'
    }
  end
end