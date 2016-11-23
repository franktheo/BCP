class TaggingsController < ApplicationController
  before_action :set_tagging, only: [:show, :edit, :update, :destroy]

  # GET /taggings
  def index
    @taggings = Tagging.all
    render json: @taggings
  end

  # GET /taggings/1
  def show
    render json: @tagging
  end

  # GET /taggings/:entity_type/:entity_id
  def show2
    @tagging = Tagging.where(entity_type: params[:entity_type], entity_id: params[:entity_id])
    if @tagging.exists?
       render json: @tagging 
    else
       render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  # GET /stats
  def stats
    @taggings = Tagging.all
    tagging = Tagging.new
    @array = tagging.get_all_stats(@taggings)
    render json: @array
  end

  # GET /stats/:entity_type/:entity_id
  def stats2
    @tagging = Tagging.where(entity_type: params[:entity_type], entity_id: params[:entity_id])
    tagging = Tagging.new
    @array = tagging.get_stats(@tagging)
    render json: @array
  end

  # POST /taggings
  # Will check if an entry with the same entity_type and entity_id exists, if exist it will be deleted
  # and replaced by the new entry. In most cases, tags will be updated. If tags are the same then
  # time stamp will be updated
  def create

    @tagging = Tagging.where(entity_type: tagging_params[:entity_type], entity_id: tagging_params[:entity_id]).first
    @tagging.destroy if @tagging.present?

    tags_elements = get_tags_elements

    @tagging = Tagging.new(entity_type: tagging_params[:entity_type], entity_id: tagging_params[:entity_id], tags: tags_elements)

    if @tagging.save
      render :show, status: :created, location: @tagging
    else
      render json: @tagging.errors, status: :unprocessable_entity
    end

  end

  # PUT /taggings/:entity_type/:entity_id
  # PUT /taggings/:entity_type/:entity_id.json
  def update2
    @tagging = Tagging.where(entity_type: params[:entity_type], entity_id: params[:entity_id]).first

    if @tagging.present?
      tags_elements = get_tags_elements
    
      if @tagging.update(entity_type: tagging_params[:entity_type], entity_id: tagging_params[:entity_id], tags: tags_elements)
        render :show, status: :ok, location: @tagging 
      else
        render json: @tagging.errors, status: :unprocessable_entity
      end
    end

  end

  # DELETE /taggings/:entity_type/:entity_id
  # DELETE /taggings/:entity_type/:entity_id.json
  def destroy2
    @tagging = Tagging.where(entity_type: params[:entity_type], entity_id: params[:entity_id]).first
    @tagging.destroy
    respond_to do |format|
      format.html { redirect_to taggings_url, notice: 'Tagging was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tagging
      @tagging = Tagging.find(params[:id])
    end

    def get_tags_elements
      tags = tagging_params[:tags].split(/\W+/)
      tags_elements = []
      for i in 1..tags.size-1
        tags_elements[i-1] = tags[i]
      end
      tags_elements
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tagging_params
      params.require(:tagging).permit(:entity_type, :entity_id, :tags)
    end
end
