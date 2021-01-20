class AddIngredientsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :ingredients, :text
  end
end
