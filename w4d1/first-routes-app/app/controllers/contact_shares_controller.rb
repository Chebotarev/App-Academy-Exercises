class ContactSharesController < ApplicationController

  def create
    @contact_share = ContactShare.new(contact_share_params)
    if @contact_share.save
      render json: @contact_share
    else
      render(
        json: @contact_share.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    begin
      @contact_share = ContactShare.find(params[:id])
      @contact_share.destroy
      render json: @contact_share
    rescue ActiveRecord::RecordNotFound => e
      render json: e.message
    end
  end

  private
    def contact_share_params
      params.require(:contact_share).permit(:contact_id, :user_id)
    end
end
