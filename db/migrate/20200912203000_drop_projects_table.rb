class DropProjectsTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :proje
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
