class Admin::HomesController < ApplicationController

  def top
    @orders = Order.page(params[:page])
  end

  def about

  end

end
