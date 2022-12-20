class Public::ProductsController < ApplicationController
  def index
    @genres = Genre.all
    @products = Product.page(params[:page])
  end

  def show
    @cart = Cart.new
    @genres = Genre.all
    @product = Product.find(params[:id])
  end
end
