class HotelsController < ApplicationController

  def index
    @hotels = Hotel.new.getAll()
    render json: @hotels
  end

  def search
    unless params[:q]
      render status: 400, json: { status: 400,  reason: 'Missing search parameter'}
    else
      @hotels = Hotel.new.search(params[:q])
      render json: @hotels
    end
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(params[:hotel])
    begin
      _hotel = Hotel.new.createOnApi(params[:hotel])
      redirect_to [_hotel], notice: 'Hotel created'
    rescue
      flash[:notice] = 'Hotel not created'
      render action: "new"
    end
  end

  def edit
    @hotel = Hotel.new
    begin
      @hotel = Hotel.new.findById(params[:id])
    rescue
      flash[:notice] = 'Hotel not found'
    end
  end
end
