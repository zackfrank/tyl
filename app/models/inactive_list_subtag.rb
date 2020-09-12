# == Schema Information
#
# Table name: inactive_list_subtags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  list_id    :integer          not null
#  tag_id     :integer          not null
#
# Indexes
#
#  index_on_list_id_and_tag_id  (list_id,tag_id) UNIQUE
#
class InactiveListSubtag < ApplicationRecord
  belongs_to :list
  belongs_to :tag
end
