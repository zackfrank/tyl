class CardsController < ApplicationController
  def index
    render json: Card.all.as_json
  end
end
