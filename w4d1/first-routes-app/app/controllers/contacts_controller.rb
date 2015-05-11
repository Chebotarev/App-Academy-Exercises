class ContactsController < ApplicationController

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    begin
      @contact = Contact.find(params[:id])
      @contact.destroy
      render json: @contact
    rescue ActiveRecord::RecordNotFound => e
      render json: e.message
    end
  end

  def index
    @user = User.find(params[:user_id])
    @contacts = @user.contacts
    @shared_contacts = @user.shared_contacts

    render json: @contacts + @shared_contacts
  end

  def show
    begin
      @contact = Contact.find(params[:id])
      render json: @contact
    rescue ActiveRecord::RecordNotFound => e
      render json: e.message
    end
  end

  def update
    begin
      @contact = Contact.find(params[:id])
      @contact.update_attributes(contact_params)
      if @contact.save
        render json: @contact
      else
        render(
          json: @contact.errors.full_messages, status: :unprocessable_entity
        )
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: e.message
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :user_id)
    end
end
