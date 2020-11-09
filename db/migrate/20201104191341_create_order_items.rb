class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.decimal :unit_price, default: 0.00
      t.integer :quantity, default: 0
      t.decimal :total_amount, default: 0.00

      t.timestamps
    end
  end
end
