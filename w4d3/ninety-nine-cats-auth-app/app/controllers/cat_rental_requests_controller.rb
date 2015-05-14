class CatRentalRequestsController < ApplicationController

  before_action :owns_cat, only: [:approve, :deny]

  # def index
  #   render json: Cat.find(params[:cat_id]).cat_rental_requests
  # end

  def new
    if params[:cat_id].nil?
      @new_request = CatRentalRequest.new
    else
      @new_request = CatRentalRequest.new(cat_id: params[:cat_id])
      @cat = Cat.find(params[:cat_id])
    end
    @cats = Cat.all
    # render :new isn't needed; it's implicit
  end

  def create
    @new_request = CatRentalRequest.new(cat_rental_request_params)
    @new_request.user_id = current_user.id
    if @new_request.save
      redirect_to cat_url(@new_request.cat)
    else
      flash.now[:errors] = @new_request.errors.full_messages
      render :new
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render json: @cat_rental_request
  end


  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny! # deny!
    redirect_to cat_url(@request.cat_id)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
  end

  def owns_cat
    request = CatRentalRequest.find(params[:id])
    redirect_to cats_url unless request.cat.owner.id == current_user.id
  end

end
