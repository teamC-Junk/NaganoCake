class Public::CustomersController < ApplicationController

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
    @customer = current_customer
    # is_activeカラムをfalseに変更することにより削除フラグを立てる
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会が完了しました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  private
  # 編集データのストロングパラメータ
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :email)
  end

end
