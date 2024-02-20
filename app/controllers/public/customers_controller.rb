class Public::CustomersController < ApplicationController
before_action :customer_state, only: [:create]

  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    
    if @customer.update(customer_params)
      flash[:notice] = "You have updated customer successfully."
      redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  # 
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :email)
  end


  # 会員ステータスがアクティブであるかを判断するメソッド
  def customer_state
    # 入力されたemailからアカウントを1件取得
    customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if customer.nil?
    return unless customer.valid_password?(params[:customer][:password])
    # アクティブな顧客はcreateアクションを実行
    # 退会している顧客はサインアップ画面に遷移する
    unless customer.is_active
      return new_customer_registration_path
    end
  end
end
