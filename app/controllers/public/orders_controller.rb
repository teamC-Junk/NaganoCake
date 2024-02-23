class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer_info = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    # new 画面から渡ってきたデータ
    @customer_info = current_customer
  
    if params[:order][:address_number] == "self_address"
      # view で定義している address_number が"self_address"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
      @order.post_code = current_customer.post_code
    elsif params[:order][:address_number] == "registered_address"
      # view で定義している address_number が"registered_address"
      address = Address.find_by(id: params[:order][:address_id])
      # view で定義している address_number が"registered_address"
      if address.present?
        @order.name = address.name
        @order.address = address.address
      else
        flash.now[:error] = "選択された登録済み住所は存在しません"
        render :new
      end
    elsif params[:order][:address_number] == "new_address"
      # view で定義している address_number が"new_address"
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
        
      else
        render :new
        # ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
      end
    else
      render :new
      # バグで上記以外の条件が発生した場合の処理
    end

    @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
    # 合計金額を出す処理です sum_price はモデルで定義したメソッドです

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
    params.require(:order).permit(:name, :address, :total_payment)
  end

  def address_params
    params.require(:order).permit(:name, :address, :post_code)
  end
end
