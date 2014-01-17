class DistanceController < ApplicationController
  def search
    @latitude = params[:latitude].to_f * Math::PI / 180
    @longitude = params[:longitude].to_f * Math::PI / 180
    @users = Location.search :geo => [@latitude, @longitude], :with => {:geodist => 0.0..200_000.0}, :order => "geodist ASC"
  end
  end