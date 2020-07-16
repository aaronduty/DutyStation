class AddOrderToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :order, :integer, default: 0
  end
end
