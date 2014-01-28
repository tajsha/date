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
         location  = Location.find_by_zipcode params[:zipcode] 
          latitude  = location.latitude * Math::PI / 180 
          longitude = location.longitude * Math::PI / 180 

          location_zips = Location.search_for_ids( 
            :geo   => [latitude, longitude], 
            :with  => {:geodist => 0.0..400_000.0}, 
            :order => 'geodist ASC',
            :per_page => 1_000
          ) 
          @users = Users.where(zip_code: location_zips.pluck(:zipcode))
          
                 
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