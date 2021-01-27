class AddScheduleToProduct < ActiveRecord::Migration[6.0]
  def change
  	add_column :products, :days, :text, array: true, default: [0,0,0,0,0,0,0]
  	add_column :products, :schedule, :text, array: true, default: [0,0,0,0]
  end
end
