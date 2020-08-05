class Task < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :project
  belongs_to :status

  has_many :tasks

  enum priority: { LOW: 0, MEDIUM: 1, HIGH: 2 }
end
