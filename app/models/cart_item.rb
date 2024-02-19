class CartItem < ApplicationRecord
  belongs_to :customer  # 会員との関連付け (1対多)
  belongs_to :item      # 商品との関連付け (1対多)
end
