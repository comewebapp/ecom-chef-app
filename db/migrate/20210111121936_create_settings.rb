class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.float :delivery_price, default: 2.5

      t.timestamps
    end
  end
end
