class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    # @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price}
  end

  def update

  end

  def destroy
    @cart_item.destroy
    redirect_to request.referer, notice: "カート内商品の一つを削除しました。"
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to request.referer
  end

  def create
  end
  private
  def cart_items_params
    params.require(:cart_items).permit(:amount)
  end
end
