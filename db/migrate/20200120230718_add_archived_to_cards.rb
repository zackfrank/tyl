class AddArchivedToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :archived, :boolean, default: false
  end
end
