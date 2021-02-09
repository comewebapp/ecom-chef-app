class Admin::CollectionsController < Admin::ApplicationController

	before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
  	# @collections = ShopifyAPI::CustomCollection.all# + ShopifyAPI::SmartCollection.all
  	@collections = Collection.all
  end

  def new
    @collection = Collection.new
  end

  def show
  end

  def edit
  end

  def create
    @collection = Collection.new(collection_params)
    respond_to do |format|
      if @collection.save
        format.html { redirect_to admin_collections_path, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @collection.update(collection_params)
      redirect_to [:admin, @collection], notice: 'Collection was successfully update'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collection_params
      params.require(:collection).permit(:title)
    end

end
