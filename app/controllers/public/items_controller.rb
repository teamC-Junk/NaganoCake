class Public::ItemsController < ApplicationController
    before_action :authenticate_customer!
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def all_genre
    @genres = Genre.all
  end

  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :introduction, :price, :is_active)
  end

end
