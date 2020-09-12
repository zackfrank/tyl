class CreateListTags < ActiveRecord::Migration[5.2]
  def change
    create_table :list_tags do |t|
      t.integer :list_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end

    add_index :list_tags, [:list_id, :tag_id], name: :index_list_tags_on_list_id_and_tag_id, unique: true
  end
end
