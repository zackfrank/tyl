class InactiveListSubtag < ApplicationRecord
  belongs_to :list
  belongs_to :tag
end
