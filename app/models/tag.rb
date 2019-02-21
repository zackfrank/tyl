class Tag < ApplicationRecord
  has_many :task_tags
  has_many :tasks, through: :task_tags

  def as_json
    {
      id: id,
      name: name
    }
  end
end
