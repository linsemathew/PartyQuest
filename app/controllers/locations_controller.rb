class LocationsController < ApplicationController

   before_action :current_user, only: [:create, :new, :edit, :destroy]

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find_by(id: params[:id])
    @user = current_user
  end

  def new
    if @current_user
      @location = Location.new
    else
      redirect_to '/login'
    end
  end

  def create
    @location = Location.find_or_create_by(location_params)
    if @location.save
      flash[:success] = "You've successfully created your location!"
    else
      @errors = @location.errors.full_messages
      flash[:danger] = "Oops! We couldn't create your location!"
      render 'new'
    end
  end

  private

  def location_params
    params.require(:location).permit(:latitude, :longitude, :address, :city, :state, :campaign_id)
  end

end