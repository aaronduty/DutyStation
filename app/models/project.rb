class Project < ApplicationRecord
    has_many :tasks, -> { order(priority: :desc, updated_at: :desc) }, dependent: :destroy
    has_many :statuses, -> { order(:order) }, dependent: :destroy
end
