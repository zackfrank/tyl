class CreateInactiveListSubtags < ActiveRecord::Migration[5.2]
  def change
    create_table :inactive_list_subtags do |t|
      t.integer :list_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end

    add_index :inactive_list_subtags,  [:list_id, :tag_id], name: :index_on_list_id_and_tag_id, unique: true
  end
end
