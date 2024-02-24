class Order < ApplicationRecord
  belongs_to :customer    # 会員との関連付け (1対多)

  has_many :order_details, dependent: :destroy # 注文明細との関連付け (1対多)
  
  has_one_attached :image
  
  has_many :items, through: :order_details
  
  enum payment_method: { "クレジットカード": 0, "銀行振込": 1 }
  enum status: { "入金待ち": 0, "入金確認": 1, "制作中": 2, "発送準備中": 3, "発送済み": 4 }

  validates :post_code, presence:true
  validates :address, presence:true
  validates :name, presence:true
end
