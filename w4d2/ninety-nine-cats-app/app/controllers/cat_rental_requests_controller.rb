class CatRentalRequestsController < ApplicationController
  def index
    @cat = Cat.find(params[:cat_id])
    @requests = CatRentalRequest.where(cat_id: params[:cat_id])
  end

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
  end

  def create
    @cats = Cat.all
    @request = CatRentalRequest.new(cat_rental_request_params)
    if @request.save
      redirect_to cat_url(params[:cat_rental_request][:cat_id])
    else
      flash.now[:errors] = @request.errors.full_messages
      render :new
    end
  end


private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end
end
