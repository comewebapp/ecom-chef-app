class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /products
  # GET /products.json
  def index
    @products = current_user.products.order(:created_at).all
    # products = RestClient.get("https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_API_PASSWORD']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin/api/2020-01/products.json")
    products = ShopifyAPI::Product.all
  end








  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    @product.days = [params[:product][:monday], params[:product][:tuesday], params[:product][:wednesday], params[:product][:thursday], params[:product][:friday], params[:product][:saturday], params[:product][:sunday]]
    @product.schedule = [params[:product][:breakfast], params[:product][:food], params[:product][:snack], params[:product][:cena]]
    @product.image_base64 = ("data:image/png;base64," + Base64.strict_encode64(File.open(params[:product][:image_base64].path).read)) rescue nil
    respond_to do |format|
      if @product.save
        params[:product][:collection].reject(&:empty?).each do |collection_id|
          ProductCollection.create(product_id: @product.id, collection_id: collection_id)
        end
        format.html { redirect_to products_url, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.days = [params[:product][:monday], params[:product][:tuesday], params[:product][:wednesday], params[:product][:thursday], params[:product][:friday], params[:product][:saturday], params[:product][:sunday]]
        @product.schedule = [params[:product][:breakfast], params[:product][:food], params[:product][:snack], params[:product][:cena]]
        @product.image_base64 = ("data:image/png;base64," + Base64.strict_encode64(File.open(params[:product][:image_base64].path).read)) if params[:product][:image_base64].present?
        @product.status = false
        @product.save
        @product.product_collections.destroy_all
        params[:product][:collection].reject(&:empty?).each do |collection_id|
          ProductCollection.create(product_id: @product.id, collection_id: collection_id)
        end
        format.html { redirect_to products_url, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:user_id, :name, :description, :ingredients, :image, :available_quantity, :amount, :price, :weight, :size, :status, :online)
    end
end
