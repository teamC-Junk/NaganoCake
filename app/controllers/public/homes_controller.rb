class Public::HomesController < ApplicationController
  def top
    @items = Item.order(created_at: :desc).page(params[:page])
    @genres = Genre.all
  end

  def about
  end

end
