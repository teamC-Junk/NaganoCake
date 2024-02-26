class Public::HomesController < ApplicationController
    before_action :authenticate_customer!
  def top
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def about
  end

end
