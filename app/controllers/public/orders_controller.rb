class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer_info = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @customer_info = current_customer
    
    @order.shipping_fee = 800   # 送料
    @total_price = 0            # 商品合計計算用
    @consumption_tax = 1.1      # 消費税
  
    if params[:order][:select_address] == "self_address"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
      @order.post_code = current_customer.post_code
    elsif params[:order][:select_address] == "registered_address"
      address = Address.find_by(id: params[:order][:address_id])
      if address.present?
        @order.name = address.name
        @order.address = address.address
        @order.post_code = address.post_code
      else
        flash.now[:error] = "選択された登録済み住所は存在しません"
        render :new
      end
    elsif params[:order][:select_address] == "new_address"
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new # 入力不足の場合の処理
      end
    else
      render :new # バグで上記以外の条件が発生した場合の処理
    end
    
    @cart_items = current_customer.cart_items.all
  end

  def complete
  end

  def create
  end

  def index
  end

  def show
  end
  
  private
  def order_params
    params.require(:order).permit(:name, :address, :post_code, :payment_method)
  end

  def address_params
    params.require(:order).permit(:name, :address, :post_code)
  end
end
