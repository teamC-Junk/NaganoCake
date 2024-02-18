class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items, dependent: :destroy  # カート内商品との関連付け (1対多)
  has_many :orders, dependent: :destroy      # 注文との関連付け (1対多)
  has_many :addresses, dependent: :destroy   # 配送先との関連付け (1対多)
end
