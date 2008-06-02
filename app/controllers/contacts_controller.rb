class ContactsController < ApplicationController
#  before_filter :authentication

  verify :method => :post, :only => :confirm, :redirect_to => { :action => "index"}
  def index
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(params[:contact])
    respond_to do |format|
      if @contact.valid?
        format.html
      else
        format.html { render :action => "index" }
      end
    end
  end

  def submit
    @contact = Contact.new(params[:contact])
    unless params[:edit].blank?
      render :action => "index"
    else
      @contact.ip_address = request.remote_ip
      @contact.save!
      ContactMailer.deliver_message(@contact)
    end
  end
end
