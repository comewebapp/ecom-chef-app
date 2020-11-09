class ChangeCollectionIdToString < ActiveRecord::Migration[6.0]
  def change
  	change_column :product_collections, :collection_id, :string
  end
end
