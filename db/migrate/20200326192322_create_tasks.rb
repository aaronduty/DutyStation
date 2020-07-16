class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :uid
      t.string :title
      t.text :description
      t.references :task, null: true, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :uid
  end
end
