json.extract! product, :id, :user_id, :name, :description, :image, :available_quantity, :price, :size, :status, :online, :created_at, :updated_at
json.url product_url(product, format: :json)
