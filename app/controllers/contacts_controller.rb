class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      ContactMailer.new_contact(@contact).deliver
      redirect_to root_path
    else
      render :new
    end
  end
end