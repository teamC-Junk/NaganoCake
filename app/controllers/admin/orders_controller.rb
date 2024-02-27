class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @orders = Order.page(params[:page])
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    
    # 注文ステータスが「入金確認」に更新
    if @order.status == "confirmation_of_payment"
      # 制作ステータスを全商品「製作待ち」に更新
      @order_details.update_all(making_status: "pending_production")
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

  def order_detail_params
    prams.require(:order_detail).permit(:making_status)
  end
end
