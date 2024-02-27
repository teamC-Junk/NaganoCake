class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { "not_producible": 0, "pending_production": 1, "in_production": 2, "production_completed": 3 }

end
