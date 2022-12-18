class Public::CartsController < ApplicationController

  def index
    @carts = current_customer.carts
    @total_price = 0
    @cart = Cart.new
  end

  def create
    @cart = current_customer.carts.find_by(product_id: params[:cart][:product_id])
    if @cart.blank?
      current_customer.carts.build(product_id: params[:cart][:product_id], amount: params[:cart][:amount])
    else
      @cart.amount += params[:cart][:amount].to_i
    end
      @cart.save!
    redirect_to carts_path
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    redirect_to request.referer
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy!
    redirect_to request.referer
  end

  def destroy_all
    current_user.carts.destroy_all
    redirect_to request.referer
  end

  private
  def cart_params
    params.require(:cart).permit(:customer_id, :product_id, :amount)
  end

end