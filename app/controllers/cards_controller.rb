class CardsController < ApplicationController
  def index
    cards = params[:query] ? Card.where(
      "title ILIKE :query OR description ILIKE :query", query: "%#{params[:query]}%"
    ) : Card.all

    render json: cards.as_json
  end

  def update
    card = Card.find(params[:id])
    tag = Tag.find(params[:tag][:id])
    card.tags.include?(tag) ? card.tags.delete(tag) : card.tags << tag
    render json: Card.all.as_json
  end
end
