class DropTaskTagsTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :task_tags
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
