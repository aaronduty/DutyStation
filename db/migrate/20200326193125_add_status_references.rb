class AddStatusReferences < ActiveRecord::Migration[6.0]
  def change
    add_reference(:statuses, :project, null: false, foreign_key: true)
  end
end
