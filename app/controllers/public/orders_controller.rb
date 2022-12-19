class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def confirm
    # ordersessionを作成newで指定しているからいらないかな？
    session[:order] = Order.new(order_params)
    # 顧客idの保存
    session[:order][:customer_id] = current_customer.id
    # 配送料の保存
    session[:order][:postage] = 800
    # 合計金額の計算
    carts = current_customer.carts #顧客のカートを呼び出し
    @total = carts.inject(0) { |sum, cart| sum + cart.subtoal }
    # @product_total_price = 0 #合計金額用のメソッドの定義
    # carts.each do |cart| #カートの中身をeachで取り出し
    #   @product_total_price += cart.subtoal.to_i
    # end
    # 合計金額の保存(上記計算+送料)両方数値なのでto_i不要
    session[:order][:total_price] = @total + session[:order][:postage]
    # 注文ステータスの保存
    session[:order][:order_status] = 0
    # 支払い方法の保存
    session[:order][:payment_method] = params[:order][:payment_method]
    # binding.pry
    # 配送先処理
    delivery_destination = params[:order][:delivery_select].to_i
    if delivery_destination == 1
      session[:order][:delivery_postcode] = current_customer.postcode
      session[:order][:delivery_address] = current_customer.address
      session[:order][:delivery_name] = (current_customer.last_name + current_customer.first_name)
    elsif delivery_destination == 2
      delivary = Address.find(id: params[:order][:delivery_adress])
      session[:order][:delivery_postcode] = delivary.postcode
      session[:order][:delivery_address] = delivary.address
      session[:order][:delivery_name] = delivary.name
    else #delivery_destination == 3
      session[:order][:delivery_postcode] = params[:order][:delivery_postcode]
      session[:order][:delivery_address] = params[:order][:delivery_address]
      session[:order][:delivery_name] = params[:order][:delivery_name]
    end
    @carts = current_customer.carts
    @order = session[:order]
  end
  
  def complete
    
  end
  
  # def create
  #   order = Order.new(session[:order])
  #   order.save
  #   session[:order].clear
  # end

  # def show
  #   @order = Order.find(params[:id])
  #   @order_details = @order.order_details
  # end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :total_price, :order_status,
    :payment_method, :delivery_postcode, :delivery_address, :delivery_name)
  end
end