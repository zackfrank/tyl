class TagsController < ApplicationController
  
  def index
    tags = Tag.all.order(:name)
    render json: tags.as_json
  end
end
