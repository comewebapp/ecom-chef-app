class ChangeWeightToIntegerInProduct < ActiveRecord::Migration[6.0]
  def change
  	change_column :products, :weight, :integer
  end
end
