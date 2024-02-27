class Admin::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order # 注文商品から注文テーブルの呼び出し
    
    # 制作ステータスが1つでも「制作中」に更新
    if @order_detail.making_status == "in_production"
      # 注文ステータスを全商品「制作中」に更新
      @order.update(status: "in_production")
    # 「注文商品の個数」、「making_statusが「制作完了」の商品数」カウント
    # 数が一致すれば、全商品のmaking_statusが「制作完了」となる
    elsif @order.order_details.count ==  @order.order_details.where(making_status: "production_completed").count
      #注文ステータスを「発送準備中」に"自動更新"
      @order.update(status: "preparing_to_ship") 
    end
    
    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
