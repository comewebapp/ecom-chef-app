class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.decimal :sub_total, default: 0.00
      t.decimal :discount_value, default: 0.00
      t.string :discount_type, default: 'percentage'
      t.decimal :shipping_charges, default: 0.00
      t.decimal :total, default: 0.00
      t.string :payment_status, default: 'pending'

      t.timestamps
    end
  end
end
