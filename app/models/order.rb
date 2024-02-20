class Order < ApplicationRecord
  belongs_to :customer    # 会員との関連付け (1対多)
  
  has_many :order_details, dependent: :destroy # 注文明細との関連付け (1対多)
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_for_payment: 0, confirmation_of_payment: 1, in_production: 2, preparing_to_ship: 3, shipped: 4  }

end
