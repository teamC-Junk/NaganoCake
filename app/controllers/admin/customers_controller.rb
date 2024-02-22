class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    
    if @customer.update(customer_params)
      flash[:notice] = "更新が完了しました。"
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end
  
  private
  # 編集データのストロングパラメータ
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :email, :is_active)
  end
  
end