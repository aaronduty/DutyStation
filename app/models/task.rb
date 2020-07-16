class Task < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :project
  belongs_to :status

  has_many :tasks

  enum priority: { Low: 0, Medium: 1, High: 2 }
end
