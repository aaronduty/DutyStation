class Task < ApplicationRecord
  belongs_to :task, optional: true
  belongs_to :project
  belongs_to :status

  has_many :tasks

  enum priority: { LOW: 0, MEDIUM: 1, HIGH: 2 }

  before_update :reorder_tasks

  private
    def reorder_tasks
      Task.where(project: self.project, status: self.status)
        .where('"order" >= ?', self.order)
        .where.not(id: self.id)
        .update_all('"order" = "order" + 1')
    end
end
