class Item < ApplicationRecord
  belongs_to :genre # ジャンルとの関連付け (1対多)

  has_many :cart_items, dependent: :destroy    # カート内商品との関連付け (1対多)
  has_many :order_details, dependent: :destroy # 注文商品との関連付け (1対多)
  has_one_attached :image
  validates :name, :introduction, :price, :image, presence: true
  
  def get_image(width, height) 
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end 
      image.variant(resize_to_limit: [width,height]).processed
  end 

end
