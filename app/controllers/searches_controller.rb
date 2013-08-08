class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @search = Search.new(params[:search])
    if @search.save
      redirect_to @search
    else
      render 'new'
    end
  end

  def show
    @search = Search.find(params[:id])
    @users = @search.users
    end
    
    def index
       @users = User.search(params[:search])
     end
     
     
end