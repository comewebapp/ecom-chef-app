class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy

  def is_admin?
    self.role.try(:downcase) === 'admin'
  end

  def is_chef?
    self.role.try(:downcase) === 'chef'
  end
end
