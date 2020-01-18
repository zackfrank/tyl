class Card < ApplicationRecord
  has_many :card_tags
  has_many :tags, through: :card_tags

  default_scope -> { order(created_at: :desc) }
end
