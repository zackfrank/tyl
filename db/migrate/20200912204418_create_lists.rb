class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.string :sort_by, null: false, default: "created_at"
      t.string :show_option, null: false, default: "active"

      t.timestamps
    end
  end
end
