class Public::CartsController < ApplicationController

  def index
    @carts = Cart.new
    @carts.id = 1
    @carts.customer_id = 2525
    @carts.product_id = 1000
    @carts.amount = 80
    @total_price = 0
    # @carts = current_user.carts
  end

  def create
    # Cart.where(customer_id: current_user.id, product_id: params[:product_id]).exists?
    if current_user.carts.where(product_id: params[:product_id]).exists?
      @cart = Cart.find_by(customer_id: current_user.id, product_id: params[:product_id])
      @cart.amount += params[:amount].to_i
      @cart.update!(cart_params)
    else
      @cart = Cart.new(cart_params)
      @cart.customer_id = current_user.id
      @cart.product_id = params[:product_id]
      @cart.amount = params[:amount]
      @cart.save!
    end
    # params[:product_id]は暫定。商品名で送信ならfind_by(params[:name])に変更
    redirect_to public_carts_path
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.amount = params[:amount]
    @cart.update
    redirect_to request.referer
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy!
    redirect_to request.referer
  end

  def destroy_all
    current_user.carts.destroy_all
  end

  private
  def cart_params
    params.require(:cart).permit(:customer_id, :product_id, :amount)
  end
end

# public/carts