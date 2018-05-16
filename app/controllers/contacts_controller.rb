class ContactsController < ApplicationController

  def create
    company = Company.find(params[:company_id])
    @contact = company.contacts.new(contact_params)
    if @contact.save
      flash[:success] = "#{@contact.full_name} added!"
    else
      flash[:notice] = 'You must enter all info for your contact'
    end
    redirect_to company_path(company)
  end

  private

  def contact_params
    params.require(:contact).permit(:full_name, :position, :email, :company_id)
  end
end
