class AddOrderToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :order, :integer, default: 0
  end
end
