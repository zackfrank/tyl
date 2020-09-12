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
