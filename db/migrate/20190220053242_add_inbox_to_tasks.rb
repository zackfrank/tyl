class AddInboxToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :inbox, :boolean, default: true
  end
end
