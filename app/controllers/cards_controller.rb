class CardsController < ApplicationController
  def index
    cards = params[:query] ? current_user.cards.where(
      "title ILIKE :query OR description ILIKE :query", query: "%#{params[:query]}%"
    ) : current_user.cards

    render json: current_user.cards.as_json
  end

  def update
    update_tag
    update_title
    update_description
    update_archived

    render json: card.as_json
  end

  def create
    card = current_user.cards.create(title: params[:title], description: params[:description])

    tags = current_user.tags
    params[:tags].each do |tag|
      tag = tag['id'] ? tags.find(tag['id']) : tags.create(name: tag['name'])
      card.tags << tag
    end

    render json: card.as_json
  end

  def destroy
    card.delete

    render json: current_user.cards.as_json
  end

  private

  def update_tag
    return unless params[:tag]

    tag = Tag.find(params[:tag][:id])
    card.tags.include?(tag) ? card.tags.delete(tag) : card.tags << tag
  end

  def update_description
    return unless params[:description]

    description = params[:description].blank? ? nil : params[:description]
    card.update(description: description)
  end

  def update_title
    return if params[:title].blank?

    card.update(title: params[:title])
  end

  def update_archived
    return unless params.has_key?(:archived)

    card.update(archived: params[:archived])
  end

  def card
    @card ||= current_user.cards.find(params[:id])
  end
end
