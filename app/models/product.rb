class Product < ApplicationRecord

  include ActionView::Helpers::NumberHelper

  has_many :product_collections
  # has_many :collections, through: :product_collections
  mount_uploader :image, AvatarUploader
  belongs_to :user

  validates_presence_of :name

  def get_image_url
    return self.image && self.image.url ? self.image.try(:url) : 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRxzT3N7-TEsb1AD_eU8B2TtTLryBLItF7cKw&usqp=CAU'
  end

  def status_name
    self.status ? "approved" : "pending"
  end

  def status_name_spanish_abbr
    self.status ? "Apr." : "Pend."
  end

  def status_name_spanish_abbr_title
    self.status ? "Aprobado" : "Pendiente"
  end

  def is_pending?
    !self.status
  end

  def is_approved?
    self.status
  end

  def delivery_price
    Setting.current.delivery_price
  end

  def delivery_price_in_euro
    number_to_currency(delivery_price, :unit => "", :separator => ",", :delimiter => ".", :format => "%u %n") + " eur" rescue nil
  end

  def image_url
    image_base64.present? ? image_base64 : ActionController::Base.helpers.asset_path('noimage.png')
  end

  def collection_names
    ids = product_collections.map(&:collection_id).join(",")
    return ShopifyAPI::CustomCollection.where(ids: ids).map(&:title).join(", ") if ids.present?
    return nil
  end

  def price_in_euro
    number_to_currency(amount, :unit => "", :separator => ",", :delimiter => ".", :format => "%u %n") + " eur" rescue nil
  end

  def total_price_in_euro
    number_to_currency(price, :unit => "", :separator => ",", :delimiter => ".", :format => "%u %n") + " eur" rescue nil
  end

  def delivery_days
    arr = []
    arr.push("Lunes") if days[0] == "1"
    arr.push("Martes") if days[1] == "1"
    arr.push("Miércoles") if days[2] == "1"
    arr.push("Jueves") if days[3] == "1"
    arr.push("Viernes") if days[4] == "1"
    arr.push("Sábado") if days[5] == "1"
    arr.push("Domingo") if days[6] == "1"
    arr.join(", ")
  end

  def delivery_hours
    arr = []
    arr.push("Desayuno") if schedule[0] == "1"
    arr.push("Comida") if schedule[1] == "1"
    arr.push("Merienda") if schedule[2] == "1"
    arr.push("Cena") if schedule[3] == "1"
    arr.join(", ")
  end
    
end
