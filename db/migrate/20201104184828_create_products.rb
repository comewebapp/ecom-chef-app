class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :image
      t.integer :available_quantity, default: 0
      t.decimal :price, default: 0.00
      t.string :size, default: 'S'
      t.boolean :status, default: false
      t.boolean :online, default: true

      t.timestamps
    end
  end
end
