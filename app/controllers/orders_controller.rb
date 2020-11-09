class OrdersController < ApplicationController

 def index
    @orders = ShopifyAPI::Order.all
 end

end
