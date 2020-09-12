# == Schema Information
#
# Table name: card_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_id    :integer
#  tag_id     :integer
#
# Indexes
#
#  index_on_card_id_and_tag_id  (card_id,tag_id) UNIQUE
#
class CardTag < ApplicationRecord
  belongs_to :card
  belongs_to :tag
end
