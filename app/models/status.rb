class Status < ApplicationRecord
  belongs_to :project

  has_many :tasks, -> { order(order: :asc, priority: :desc, updated_at: :desc) }, dependent: :destroy
end
