class PicturesController < ApplicationController
  load_and_authorize_resource
  before_filter :load_attachable_picture

  def index
    @pictures = @attachable_picture.pictures
    respond_to do |format|
      format.html {
        render :partial => "pictures/pictures", :locals => {}
      }
    end
  end

  def carousel
    @pictures = @attachable_picture.pictures.order("created_at asc")
    if params[:active_picture_id]
      @active_picture = @attachable_picture.pictures.find(params[:active_picture_id])
    else
      @active_picture = @attachable_picture.pictures.first
    end
    respond_to do |format|
      format.html {
        render :partial => "pictures/pictures_carousel", :locals => {:active_picture => @active_picture}
      }
    end
  end

  def new
    @picture  = @attachable_picture.pictures.new
  end

  def edit
    @picture = @attachable_picture.pictures.find(params[:id])
    respond_to do |format|
      format.html {
        render :partial => "pictures/form_description", :locals => {:attachable_picture => @attachable_picture, :picture => @picture}
      }
    end
  end

  def update
    @picture = @attachable_picture.pictures.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { head :ok }
        format.json { head :no_content }
      else
        format.html { }
        format.json { render json: @booking_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    # Workaround for Rails 3.2.13, see: https://github.com/tors/jquery-fileupload-rails/issues/36
    #params[:picture][:image] = params[:picture][:image][0]
    @picture = @attachable_picture.pictures.new(params[:picture])
    if @picture.save
      flash[:notice] = "Picture created."
    else
      #render :new
    end
  end

  def destroy
    @picture = @attachable_picture.pictures.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to @attachable_picture, :flash => { :notice => "Picture deleted" } }
      #format.html { redirect_to @attachable_picture, notice: "Picture deleted" }
      format.json { head :no_content }
    end
  end



  private

  def load_attachable_picture
    resource, id = request.path.split('/')[1,2]
    @attachable_picture = resource.singularize.classify.constantize.find(id)
  end
end
