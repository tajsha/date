
2
3
4
5
6
7
8
9
10
11
12
13
14
15
class ProfileController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
     @user = User.new(params[:user])
      if @user.save
        redirect_to root_url, notice: "Profile updated!"
      else
        render "new"
      end
    end
  end