class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :project_id
      t.date :due_date
      t.integer :order
      t.boolean :active
      t.boolean :completed

      t.timestamps
    end
  end
end
