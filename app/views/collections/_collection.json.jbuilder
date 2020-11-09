json.extract! collection, :id, :title, :description, :image, :created_at, :updated_at
json.url collection_url(collection, format: :json)
