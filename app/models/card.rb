# == Schema Information
#
# Table name: cards
#
#  id          :bigint           not null, primary key
#  archived    :boolean          default(FALSE)
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Card < ApplicationRecord
  has_many :card_tags, dependent: :destroy
  has_many :tags, through: :card_tags
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  def as_json
    {
      id: id,
      title: title,
      description: description,
      tags: tags.map { |tag| { id: tag.id, name: tag.name } },
      archived: archived,
      date_created: created_at.strftime('%m/%d/%Y'),
      created_at: created_at.to_i,
      updated_at: updated_at.to_i
    }
  end
end
