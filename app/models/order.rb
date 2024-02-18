class Order < ApplicationRecord
  belongs_to :customer    # 会員との関連付け (1対多)
  
  has_many :order_details, dependent: :destroy # 注文明細との関連付け (1対多)
end
