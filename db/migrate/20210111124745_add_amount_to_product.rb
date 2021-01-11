class AddAmountToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :amount, :decimal, default: "0.0"
  end
end
