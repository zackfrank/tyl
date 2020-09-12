class Tag < ApplicationRecord
  has_many :card_tags, dependent: :destroy
  has_many :cards, through: :card_tags
  has_many :list_tags, dependent: :destroy
  has_many :lists, through: :list_tags
  belongs_to :user

  def as_json
    {
      id: id,
      name: name
    }
  end
end
