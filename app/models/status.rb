class Status < ApplicationRecord
  belongs_to :project

  has_many :tasks, -> { order(order: :asc, priority: :desc, updated_at: :desc) }, dependent: :destroy

  before_create :set_order_on_create

  private
    def set_order_on_create
      if self.order.nil?
        self.order = self.project.statuses.maximum(:order) + 1
      else
        order_start = self.order
        statuses = self.project.statuses.where('"order" >= ?', order_start)
        statuses.each do |status|
          order_start += 1
          status.order = order_start
        end
        statuses.update_all
      end
    end
end
