class TagsController < ApplicationController
  
  def index
    tags = current_user.tags.order(:name).as_json
    render json: tags
  end

  def create
    tag = current_user.tags.find_by(name: params[:name]) ? nil : current_user.tags.create(name: params[:name]).as_json

    render json: tag
  end

  def update
    tag.update(name: params[:name])

    render json: tag.as_json
  end

  def destroy
    tag.delete

    head :ok
  end

  private

  def tag
    @tag ||= current_user.tags.find(params[:id])
  end
end
