class Admin::ProductsController < Admin::ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :approve]
  def index
    @products = Product.all.order('id DESC')
  end

  def show
  end

  def update
    if @product.update(product_params)
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
    @product.destroy
    redirect_back(fallback_location: root_path)
  end

  def approve
    @product.update(status: true)

    new_product = ShopifyAPI::Product.new
    new_product.title = @product.name
    new_product.description = @product.description
    new_product.stock = @product.available_quantity
    new_product.price = @product.price
    # new_product.product_type = "Snowboard"
    # new_product.vendor = "Burton"
    new_product.save

    @product.product_collections.each do |product_collection|
      collection = ShopifyAPI::CustomCollection.find(product_collection.collection_id)
      collection.add_product new_product
    end

    redirect_to admin_products_path, notice: 'Product is approved'
  end

  private
  def set_product
    @product = Product.find_by_id(params[:id])
  end
  def product_params
    params.require(:product).permit(:user_id, :name, :description, :image, :available_quantity, :price, :size, :status, :online)
  end
end