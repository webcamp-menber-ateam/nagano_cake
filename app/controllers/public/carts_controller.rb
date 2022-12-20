class Public::CartsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart = Cart.new
    @carts = current_customer.carts
    @total_price = 0
  end

  def create
    @cart = current_customer.carts.find_by(product_id: params[:cart][:product_id])
    if @cart.blank?
      @cart = current_customer.carts.build(product_id: params[:cart][:product_id], amount: params[:cart][:amount])
    else
      @cart.amount += params[:cart][:amount].to_i
    end
    if @cart.save
      redirect_to carts_path, notice: "商品を追加しました"
    else
      @product = Product.find_by(id: params[:cart][:product_id])
      redirect_to product_path(@product.id), notice: "購入数を選択してください。"
    end
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update(cart_params)
      redirect_to request.referer, notice: "商品の個数を変更しました"
    else
      render 'index'
    end
  end

  def destroy
    cart = Cart.find(params[:id])
    if cart.destroy
      redirect_to request.referer, notice: "商品を削除しました"
    else
      render 'index'
    end
  end

  def destroy_all
    if current_customer.carts.destroy_all
      redirect_to request.referer, notice: "商品を全て削除しました"
    else
      render 'index'
    end
  end

  private
  def cart_params
    params.require(:cart).permit(:customer_id, :product_id, :amount)
  end

end