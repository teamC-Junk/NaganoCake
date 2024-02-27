class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id

    if @address.save
      flash[:notice] = "新しい配送先を追加しました。"
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      flash[:notice] = "更新が完了しました。"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:notice] = "配送先を削除しました。"
    redirect_to addresses_path
  end

  private
  # 新規配送先用のストロングパラメータ
  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end
end
