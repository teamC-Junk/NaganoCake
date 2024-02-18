class Genre < ApplicationRecord
  has_many :items  #商品との関連付け (1対多)
end
