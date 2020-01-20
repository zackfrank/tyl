class CardsController < ApplicationController
  def index
    cards = params[:query] ? Card.where(
      "title ILIKE :query OR description ILIKE :query", query: "%#{params[:query]}%"
    ) : Card.all

    render json: cards.as_json
  end

  def update
    update_tag
    update_description

    render json: Card.all.as_json
  end

  def create
    card = Card.create(title: params[:title])

    render json: card.as_json
  end

  def update_tag
    return unless params[:tag]

    tag = Tag.find(params[:tag][:id])
    card.tags.include?(tag) ? card.tags.delete(tag) : card.tags << tag
  end

  def update_description
    return unless params[:description]

    card.update(description: params[:description])
  end

  def card
    @card ||= Card.find(params[:id])
  end
end
