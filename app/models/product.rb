class Product < ApplicationRecord

  has_many :product_collections
  has_many :collections, through: :product_collections
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
    self.status ? "Aprovado" : "Pendiente"
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

  def image_url
    image_base64.present? ? image_base64 : ActionController::Base.helpers.asset_path('noimage.png')
  end
    
end
