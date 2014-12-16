class SearchesController < ApplicationController
  

  def new
    @search = Search.new
    render layout: 'new_application'
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
    @user = current_user
    @search = Search.find(params[:id])
    @users = @search.users
    render 'users/index', layout: 'new_application'    
  end

  def update
    @search = Search.find(params[:id])
    if @search.update_attributes(params[:search])
        redirect_to @search
    else
      render 'new'
    end
  end
  
  def index
    @search = Search.new
    
    if location = Location.find_by_zip_code(params[:search])
        latitude  = location.latitude * Math::PI / 180 
        longitude = location.longitude * Math::PI / 180 

        locations = Location.search( 
          :geo   => [latitude, longitude], 
          :with  => {:geodist => 0.0..100_000.0}, 
          :order => 'geodist ASC',
          :per_page => 5_000
        ) 
        @users = User.where(zip_code: locations.map(&:zip_code))
       
          else
            @users = User.search(params[:query],
            :conditions => {:ethnicity => params[:ethnicity], :religion => params[:religion], :children => params[:children], :gender => params[:gender]},
            :with => {:age => (params[:min_age].to_i)..(params[:max_age].to_i), :geodist => 0.0..100_000.0},
            :geo => [current_user.latitude * Math::PI / 180.0, current_user.longitude * Math::PI / 180.0],
            :order => 'geodist ASC', :without => {:user_id => current_user.id})      
        

        end
        render 'users/index', layout: 'new_application'    
        
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