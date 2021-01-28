class AddShopifyProductIdToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :shopify_product_id, :string
  end
end
