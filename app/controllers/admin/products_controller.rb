class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @genres = Genre.all
  end

  def new
    @product = Product.new
    @genre = Genre.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def product_params
    params.require(:product).permit(:image, :genre_id, :name, :explanation, :price, :is_active)
  end

end
