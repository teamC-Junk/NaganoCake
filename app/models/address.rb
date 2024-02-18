class Address < ApplicationRecord
  belongs_to :customer  # 会員との関連付け (1対多)
end