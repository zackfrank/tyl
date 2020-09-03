class AddIndexToCardTags < ActiveRecord::Migration[5.2]
  def change
    add_index :card_tags, [:card_id, :tag_id], name: :index_on_card_id_and_tag_id, unique: true
  end
end
