class PhotosController < ApplicationController
  def index
  	@photos = Photo.page(params[:page] || 1).per(4)
    # ajax request will result in request.xhr? not nil
    # layout will be true if request is not an ajax request
    render action: :index, layout: request.xhr? == nil
  end
end
