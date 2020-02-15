class TagsController < ApplicationController
  
  def index
    tags = Tag.all.order(:name).as_json
    render json: tags
  end

  def create
    tag = Tag.find_by(name: params[:name]) ? nil : Tag.create(name: params[:name]).as_json

    render json: tag
  end

  def update
    tag.update(name: params[:name])

    render json: tag.as_json
  end

  def destroy
    tag.delete

    render status: :ok
  end

  private

  def tag
    @tag ||= Tag.find(params[:id])
  end
end
