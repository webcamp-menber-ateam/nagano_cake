class Admin::ProductsController < Admin::ApplicationController

  def index
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @genre = Genre.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "商品を登録しました。"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "商品を編集しました。"
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :genre_id, :name, :explanation, :price, :is_active)
  end

end
