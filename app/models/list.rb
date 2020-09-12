# == Schema Information
#
# Table name: lists
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  show_option :string           default("active"), not null
#  sort_by     :string           default("created_at"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
class List < ApplicationRecord
  has_many :tags
  has_many :inactive_list_subtags, dependent: :destroy
  has_many :inactive_subtags, through: :inactive_list_subtags, source: :tag
  belongs_to :user

  def subtags
    user.cards
        .select { |card| (tags & card.tags).present? }
        .flat_map(&:tags)
        .uniq
        .-(tags)
  end
end
