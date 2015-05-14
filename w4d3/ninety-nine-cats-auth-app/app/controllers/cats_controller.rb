class CatsController < ApplicationController

  before_action :owns_cat, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.includes(:owner).find(params[:id])
    @ordered_requests = @cat.cat_rental_requests.includes(:requester).order("start_date")
    @pending_requests = @ordered_requests.select { |request| request.status == "PENDING" }
    @approved_requests = @ordered_requests.select { |request| request.status == "APPROVED"}
    render :show
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    new_cat = Cat.new(cat_params)
    new_cat.user_id = current_user.id
    if new_cat.save
      redirect_to cat_url(new_cat)
    else
      flash.now[:errors] << @cat.errors.full_messages
      render :new
    end
  end

  private

  def owns_cat
    redirect_to cats_url unless current_user.id == params[:user_id]
  end

  def cat_params
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end


#   Index/show pages
#
# Add a cats resource; generate a cats controller
# Build an index page of all Cats.
# Keep it simple; list the cats and link to the show pages.
# Build a show page for a single cat.
# Keep it simple; just show the cat's attributes.
# Learn how to use a table (table, tr, td, th tags) to format the cat's vital information.
end
