class PhotosController < ApplicationController
	respond_to :html, :xml, :json
	def index
		@photos = Photo.page(params[:page] || 1).per(4)
		@tags = Tag.all
		# ajax request will result in request.xhr? not nil
		# layout will be true if request is not an ajax request
		#render action: :index, layout: request.xhr? == nil
	end

  	def update
	    @photo = Photo.find(params[:id])
	    new_attributes = params.require(:photo).permit(:tag_list)
	    @photo.update_attributes(new_attributes)
	    respond_with @photo
	end

	def dnd_add_tag
		photo = Photo.find(params[:id])
		tag_id = params[:tag_id]
		if tag_id.to_i == 0
			photo.tags = []
		else
			tag = Tag.find(tag_id)
			photo.tags << tag
		end
		#render json: ..., status: ...
		render text: photo.tag_list
	end

	def from_tag
	    #@selected = Tag.find(params[:tag_id]).photos
	    tag_id = params[:tag_id]
	    if tag_id.to_i == 0
	    	@selected = Photo.includes(:tags).where(tags: { id: nil }).page(params[:page] || 1).per(4)
	    else
	    	@selected = Tag.find(tag_id).photos.page(params[:page] || 1).per(4)
	    	#Photo.includes(:tags).where(tags: { id: params[:tag_id] }).page(params[:page] || 1).per(4)
	    end
	    respond_to do |format|
	        format.js
	    end
	end

	def get_all_tags
		@tags = Tag.all
	end

	private

	def photo_params
	  params.require(:photo).permit(:title, :tag_list)
	end
end
