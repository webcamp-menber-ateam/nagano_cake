class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def confirm
    binding.pry
    # ordersessionを作成newで指定しているからいらないかな？
    session[:order] = Order.new()
    # 顧客idの保存
    session[:order][:customer_id] = current_customer.id
    # 配送料の保存
    session[:order][:postage] = 800
    # 合計金額の計算
    carts = current_customer.carts #顧客のカートを呼び出し
    @total = carts.inject(0) { |sum, cart| sum + cart.subtoal } #26400
    # @product_total_price = 0 #合計金額用のメソッドの定義
    # carts.each do |cart| #カートの中身をeachで取り出し
    #   @product_total_price += cart.subtoal.to_i
    # end
    # 合計金額の保存(上記計算+送料)両方数値なのでto_i不要
    session[:order][:total_price] = @total + session[:order][:postage]
    # 注文ステータスの保存
    session[:order][:order_status] = 0
    # 支払い方法の保存
    session[:order][:payment_method] = params[:order][:payment_method].to_i
    
    # 配送先処理
    delivery_destination = params[:order][:delivary_select].to_i
    if delivery_destination == 1
      session[:order][:delivary_postcode] = current_customer.postcode
      session[:order][:delivary_adress] = current_customer.adress
      session[:order][:delivary_name] = (current_customer.last_name + current_customer.first_name)
    elsif delivery_destination == 2
      delivary = Address.find(id: params[:order][:delivary_adress])
      session[:order][:delivary_postcode] = delivary.postcode
      session[:order][:delivary_adress] = delivary.address
      session[:order][:delivary_name] = delivary.name
    else #delivery_destination == 3
      session[:order][:delivary_postcode] = params[:order][:delivary_postcode]
      session[:order][:delivary_adress] = params[:order][:delivary_adress]
      session[:order][:delivary_name] = params[:order[:delivary_name]
    end
    @carts = current_customer.carts
    redirect_to confirm_orders_path
  end
  
  def complete
    
  end
  
  def create
    order = Order.new(session[:order])
    order.save
    session[:order].clear
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
end

# 日本語表示 order.payment_method_i18n

# 		# お届け先情報に漏れがあればリダイレクト
# 		if session[:order][:post_code].presence && session[:order][:address].presence && session[:order][:name].presence
# 			redirect_to new_customers_order_path
# 		else
# 			redirect_to customers_orders_about_path
		


# 	def complete
# 		if session[:new_address]
# 			shipping_address = current_customer.shipping_addresses.new
# 			shipping_address.postal_code = order.post_code
# 			shipping_address.address = order.address
# 			shipping_address.name = order.name
# 			shipping_address.save
# 			session[:new_address] = nil
# 		end

# 		# 以下、order_detail作成
# 		cart_items = current_customer.cart_items
# 		cart_items.each do |cart_item|
# 			order_detail = OrderDetail.new
# 			order_detail.order_id = order.id
# 			order_detail.item_id = cart_item.item.id
# 			order_detail.quantity = cart_item.quantity
# 			order_detail.making_status = 0
# 			order_detail.price = (cart_item.item.price_without_tax * 1.1).floor
# 			order_detail.save
# 		end

# 		# 購入後はカート内商品削除
# 		cart_items.destroy_all
# 	end