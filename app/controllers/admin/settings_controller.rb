class Admin::SettingsController < Admin::ApplicationController

  before_action :set_setting, only: [:index, :create, :update]

  def index
  end

  def create
    if @setting.update(setting_params)
      redirect_to "/admin/settings", notice: 'Setting was successfully update'
    else
      render :edit
    end
  end

  def update
    if @setting.update(setting_params)
      redirect_to "/admin/settings", notice: 'Setting was successfully update'
    else
      render :edit
    end
  end

  def reset_stock
    Product.all.each do |product|
      product.update_attribute("available_quantity", 0)
      new_product = ShopifyAPI::Product.find product.shopify_product_id rescue nil

      if new_product

        # inventory item
        inventory_item = ShopifyAPI::InventoryItem.find new_product.variants[0].inventory_item_id rescue nil
        if inventory_item
          inventory_item.tracked = true
          inventory_item.save

          # inventory level
          params_inventory_item_ids = {inventory_item_ids: inventory_item.id}
          inventory_level = ShopifyAPI::InventoryLevel.find(:all, params: params_inventory_item_ids)[0] rescue nil

          if inventory_level && inventory_level.available != 0
            inventory_level.adjust(0 - inventory_level.available)
          end
        end
      end

    end
    redirect_to admin_settings_path
  end

  private

  def set_setting
    @setting = Setting.current
  end

  def setting_params
    params.require(:setting).permit(:delivery_price)
  end

end