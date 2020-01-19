class Card < ApplicationRecord
  has_many :card_tags
  has_many :tags, through: :card_tags

  default_scope -> { order(created_at: :desc) }

  def as_json
    {
      id: id,
      title: title,
      tags: tags.map(&:name),
      created_at: created_at.to_i,
      updated_at: updated_at.to_i
    }
  end
end
