# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_tags_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
