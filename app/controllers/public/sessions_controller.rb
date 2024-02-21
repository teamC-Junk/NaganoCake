# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  
  protected

  # 会員ステータスがアクティブであるかを判断するメソッド
  def customer_state
    # 入力されたemailからアカウントを1件取得
    customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if customer.nil?
    # パスワードが正しくない場合、このメソッドを終了する
    return unless customer.valid_password?(params[:customer][:password])
    # アクティブな顧客はcreateアクションを実行
    # 退会している顧客はサインアップ画面に遷移する

    if customer.is_active == false
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_customer_registration_path
    else
      flash[:notice] = "項目を入力してください"
    end
  end
end
