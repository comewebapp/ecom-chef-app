class AddRoleToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string, default: 'chef'
  end
end
