class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :vendor, :string
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :address, :string
    add_column :users, :postalcode, :string
    add_column :users, :city, :string
    add_column :users, :bankaccount, :string
    add_column :users, :bankname, :string
    add_column :users, :bankowner, :string
    add_column :users, :carnet, :string
  end
end
