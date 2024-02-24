class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer_info = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @customer_info = current_customer
    @cart_items = current_customer.cart_items.all

    @order.shipping_fee = 800   # 送料
    @total_price = 0            # 商品合計計算用

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
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    # カート内商品の情報を注文履歴に移動
    current_customer.cart_items.each do |cart_item|
      # 初期化
      @order_details = OrderDetail.new
      # 注履歴文商品に注文idを紐付け
      @order_details.order_id = @order.id
      # 商品idを注文履歴商品idに代入
      @order_details.item_id = cart_item.item_id
      #商品の個数を注文履歴商品の個数に代入
      @order_details.amount = cart_item.amount
      # 税込み価格算出
      @order_details.price = cart_item.item.with_tax_price
      # 注文履歴商品を保存
      @order_details.save!
    end
    # カートの中身削除
    CartItem.destroy_all
    # 注文完了画面へリダイレクト
    redirect_to orders_complete_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:name, :address, :post_code, :shipping_fee, :payment_method, :total_payment)
  end

  def address_params
    params.require(:order).permit(:name, :address, :post_code)
  end
end
