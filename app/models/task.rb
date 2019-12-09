class Task < ApplicationRecord
  has_many :task_tags
  has_many :tags, through: :task_tags
  belongs_to :project, optional: true
  validates :project_id, presence: false
  validates :due_date, presence: false
  validates :order, presence: false
  validates :active, presence: false

  default_scope -> { order(created_at: :desc) }

  def as_json
    {
      id: id,
      active: active,
      completed: completed,
      due_date: due_date,
      name: name,
      order: order,
      project_id: project_id,
      tags: tags.map(&:name)
    }
  end
end
