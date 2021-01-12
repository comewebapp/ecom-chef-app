class RemoveDefaultFromProduct < ActiveRecord::Migration[6.0]
  def change
  	change_column_default(:products, :available_quantity, nil)
  	change_column_default(:products, :weight, nil)
  	change_column_default(:products, :amount, nil)
  end
end
