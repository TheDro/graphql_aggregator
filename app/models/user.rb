class User < ApplicationRecord
  has_one :basket, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password

  after_create :create_basket

  private

  def create_basket
    Basket.create(user: self) unless basket
  end
end
