class Admin::CollectionsController < Admin::ApplicationController

  def index
  	@collections = ShopifyAPI::CustomCollection.all# + ShopifyAPI::SmartCollection.all
  end

end
