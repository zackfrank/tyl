class Tag < ApplicationRecord
  has_many :card_tags, dependent: :destroy
  has_many :cards, through: :card_tags

  def as_json
    {
      id: id,
      name: name
    }
  end
end
