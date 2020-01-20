class TagsController < ApplicationController
  
  def index
    tags = Tag.all.order(:name).as_json
    render json: tags
  end

  def create
    tag = Tag.find_by(name: params[:name]) ? nil : Tag.create(name: params[:name]).as_json

    render json: tag
  end
end
