class Project < ApplicationRecord
  has_many :tasks, -> { order(order: :asc, priority: :desc, updated_at: :desc) }, dependent: :destroy
  has_many :statuses, -> { includes(:tasks).order(:order) }, dependent: :destroy

  scope :sorted, -> { order(:order) }
end
