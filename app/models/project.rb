class Project < ApplicationRecord
  has_many :tasks, -> { order(order: :asc, priority: :desc, updated_at: :desc) }, dependent: :destroy
  has_many :statuses, -> { order(:order) }, dependent: :destroy

  scope :sorted, -> { order(:order) }
end
