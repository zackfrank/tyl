class Card < ApplicationRecord
  has_many :card_tags
  has_many :tags, through: :card_tags

  default_scope -> { order(created_at: :desc) }

  def as_json
    {
      id: id,
      title: title,
      tags: tags.map(&:name)
    }
  end
end
