class Admin::OrdersController < ApplicationController

  def show
    @orders = Order.page(params[:page])
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    if @order.update(order_params)
      @order_items.update_all(status: "制作待ち") if @order.status == "入金確認"
    end
      redirect_to request.referer
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address])
    @order.post_code = @address.post_code
    @order.address = @address.address
    @order.name = @address.name
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_fee, :total_payment, :payment_method, :status)
  end
end
