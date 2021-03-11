class Admin::ProductsController < Admin::ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :approve]
  def index
    @products = Product.all.order('id DESC')
  end

  def show
  end

  def update
    if @product.update(product_params)
      @product.product_collections.destroy_all
      params[:product][:collection].reject(&:empty?).each do |collection_id|
        ProductCollection.create(product_id: @product.id, collection_id: collection_id)
      end
      update_on_shopify
      redirect_to [:admin, @product], notice: 'Product was successfully update'
    else
      render :edit
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    if @product.save
      redirect_to [:admin, @product], notice: 'Product was successfully created'
    else
      render :new
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def destroy
    @product = Product.find_by_id(params[:id])
    shopify_product = ShopifyAPI::Product.find @product.shopify_product_id rescue nil
    shopify_product.destroy if shopify_product
    @product.destroy
    redirect_back(fallback_location: root_path)
  end

  def approve
    update_on_shopify
    @product.update(status: true)
    redirect_to admin_products_path, notice: 'Product is approved'
  end

  private

  def set_product
    @product = Product.find_by_id(params[:id])
  end

  def product_params
    params.require(:product).permit(:user_id, :name, :description, :image, :available_quantity, :price, :size, :status, :online)
  end

  def update_on_shopify
    new_product = ShopifyAPI::Product.find @product.shopify_product_id rescue nil
    new_product = ShopifyAPI::Product.new if new_product.nil?
    new_product.title = @product.name
    new_product.body_html = @product.description
    new_product.product_type = "Plato"
    new_product.vendor = @product.user.vendor
    new_product.save
    new_product.variants[0].price = @product.price
    new_product.variants[0].sku = @product.available_quantity
    # new_product.variants[0].inventory_quantity = @product.available_quantity
    new_product.variants[0].weight = @product.weight

    if new_product.save!

      @product.update(shopify_product_id: new_product.id)

      # inventory item
      inventory_item = ShopifyAPI::InventoryItem.find new_product.variants[0].inventory_item_id rescue nil
      if inventory_item
        inventory_item.tracked = true
        inventory_item.save
      end

      # images
      if @product.image_base64.present?
        new_product.images.each do |image|
          image.destroy
        end
        i = ShopifyAPI::Image.new
        i.attach_image(Base64.decode64(@product.image_base64.gsub("data:image/png;base64,", ""))) # <-- attach_image is a method, not an attribute
        new_product.images << i

        new_product.save
      end

      # ingredients
      if @product.ingredients.present?
        new_product.add_metafield(ShopifyAPI::Metafield.new({
          namespace: 'come',
          key: 'ingredientes',
          value: @product.ingredients,
          value_type: 'string'
        }))
      end

      # disponibleDias
      new_product.add_metafield(ShopifyAPI::Metafield.new({
        namespace: 'come',
        key: 'disponibleDias',
        value: @product.delivery_days.gsub(", ", "|"),
        value_type: 'string'
      }))

      # disponibleFranjas
      new_product.add_metafield(ShopifyAPI::Metafield.new({
        namespace: 'come',
        key: 'disponibleFranjas',
        value: @product.delivery_hours.gsub(", ", "|"),
        value_type: 'string'
      }))

      @product.product_collections.each do |product_collection|
        collection = ShopifyAPI::CustomCollection.find(product_collection.collection_id)
        collection.add_product new_product
      end
    end
  end

end
