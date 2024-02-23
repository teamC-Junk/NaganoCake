class CartItem < ApplicationRecord
  belongs_to :customer  # 会員との関連付け (1対多)
  belongs_to :item      # 商品との関連付け (1対多)

  validates :item_id, :amount, presence: true

  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [100,100]).processed
  end

  def sum_of_price
    item.price * amount
  end
end
