class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    # @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price}
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
  end
  private
  def cart_items_params
    params.require(:cart_items).permit(:amount)
  end
end
