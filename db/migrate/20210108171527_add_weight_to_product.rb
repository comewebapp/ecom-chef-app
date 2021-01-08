class AddWeightToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :weight, :float, default: "0.0"
  end
end
