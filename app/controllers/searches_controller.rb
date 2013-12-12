class SearchesController < ApplicationController
  
  def search
     @latitude = params[:latitude].to_f * Math::PI / 180
     @longitude = params[:longitude].to_f * Math::PI / 180
     @users = User.search :geo => [@latitude, @longitude], :with => {:geodist => 0.0..200_000.0}, :order => "geodist ASC"
   end
   
   def zipcode
     @zipcode = search.new
   end
   
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
     
  def min_age
    @min_age = params[:min_age].to_i.years
  end
  
  def max_age
    @max_age = params[:max_age].to_i.years
  end
  
  def youngest_age
  @youngest_age = params[:youngest_age].years
  end

  def oldest_age
  @oldest_age = params[:oldest_age].years
   end
end