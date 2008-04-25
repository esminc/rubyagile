class ImagesController < ApplicationController
  before_filter :login_required, :except => [:show]

  def show
    @image = Image.find(params[:id])
    respond_to do |format|
      format.image do
        send_data @image.current_data,
                  :type => @image.content_type,
                  :disposition => 'inline'
      end
    end
  end
end
