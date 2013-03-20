class PicturesController < ApplicationController
  load_and_authorize_resource
  before_filter :load_attachable_picture

  def index
    @pictures = @attachable_picture.pictures
  end

  def new
    @picture  = @attachable_picture.pictures.new
  end

  def create
    @picture = @attachable_picture.pictures.new(params[:picture])
    if @picture.save
      #flash "Picture Created." # redirect_to @attachable_picture, notice: "Picture created."
    else
      render :new
    end
  end

  def destroy
    @picture = @attachable_picture.pictures.find(params[:id])
    #@note = Note.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to @attachable_picture, notice: "Picture deleted" }
      format.json { head :no_content }
    end
  end



  private

  def load_attachable_picture
    resource, id = request.path.split('/')[1,2]
    @attachable_picture = resource.singularize.classify.constantize.find(id)
  end
end
