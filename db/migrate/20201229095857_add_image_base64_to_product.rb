class AddImageBase64ToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :image_base64, :text
  end
end
