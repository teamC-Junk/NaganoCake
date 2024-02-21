class Item < ApplicationRecord
  belongs_to :genre # ジャンルとの関連付け (1対多)

  has_many :cart_items, dependent: :destroy    # カート内商品との関連付け (1対多)
  has_many :order_details, dependent: :destroy # 注文商品との関連付け (1対多)
  has_one_attached :image
  validates :name, :introduction, :price, :image, presence: true

end
