class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @customer = current_customer
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def confirm
    # ordersessionを作成
    session[:order] = Order.new(order_params)
    # 顧客idの保存
    session[:order][:customer_id] = current_customer.id
    # 配送料の保存
    session[:order][:postage] = 800
    # 合計金額の計算
    carts = current_customer.carts #顧客のカートを呼び出し
    @total = carts.inject(0) { |sum, cart| sum + cart.subtoal }
    # 合計金額の保存(上記計算+送料)両方数値なのでto_i不要
    session[:order][:total_price] = (@total + session[:order][:postage])
    # 注文ステータスの保存
    session[:order][:order_status] = 0
    # 支払い方法の保存
    session[:order][:payment_method] = params[:order][:payment_method]

    # 配送先処理
    delivery_destination = params[:order][:delivery_select].to_i
    if delivery_destination == 1
      session[:order][:delivery_postcode] = current_customer.postcode.freeze
      session[:order][:delivery_address] = current_customer.address.freeze
      session[:order][:delivery_name] = (current_customer.last_name + current_customer.first_name).freeze
    elsif delivery_destination == 2
      delivary = Address.find(id: params[:order][:delivery_adress])
      session[:order][:delivery_postcode] = delivary.postcode.freeze
      session[:order][:delivery_address] = delivary.address.freeze
      session[:order][:delivery_name] = delivary.name.freeze
    else
      session[:order][:delivery_postcode] = params[:order][:delivery_postcode].freeze
      session[:order][:delivery_address] = params[:order][:delivery_address].freeze
      session[:order][:delivery_name] = params[:order][:delivery_name].freeze
    end
    if delivery_destination == 3 && (params[:order][:delivery_postcode].blank? || params[:order][:delivery_address].blank? || params[:order][:delivery_name].blank?)
      redirect_to request.referer, notice: "お届け先の入力不足項目があります"
    end
    @carts = current_customer.carts
    @order = session[:order]
  end

  def complete

  end

  def create
    # トランザクション処理の指定(途中でエラーの場合は全てロールバックされる)
    ActiveRecord::Base.transaction do
      order = Order.new(session[:order])
      order.save

      # 商品詳細の作成
      detail_item = current_customer.carts
      detail_item.each do |item|
        order_detail = OrderDetail.new(order_detail_params)
        order_detail.order_id = order.id
        order_detail.product_id = item.product_id
        order_detail.amount = item.amount
        order_detail.price = item.product.price
        order_detail.creat_status = 0
        order_detail.save
      end
      detail_item.destroy_all
      session[:order].clear
    end
    redirect_to complete_orders_path
  end

  def show
    # confirmでリロードされた時の対策
    if params[:id] == "confirm"
      redirect_to new_order_path, notice: "リロードされた為入力画面に戻りました"
      return
    end

    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def lookup_address
    # instanceを設定しないならこう記載(ただし毎回読み込むので重くなる)
    # index = PostCodeIndex.new('KEN_ALL.csv')
    # address = index.lookup(params[:order][:delivery_postcode])
    address = PostCodeIndex.instance.lookup(params[:order][:delivery_postcode])
    if address.nil?
      redirect_to request.referer, notice: "該当する郵便番号はありませんでした"
    else
      @order = Order.new(order_params)
      @order.delivery_postcode = address[:post_code]
      @order.delivery_address = address[:prefecture] + address[:city] + address[:street]
      @customer = current_customer
      render :new
    end
  end


  private
  def order_params
    params.require(:order).permit(:customer_id, :postage, :total_price, :order_status,
    :payment_method, :delivery_postcode, :delivery_address, :delivery_name)
  end

  def order_detail_params
    params.permit(:order_id, :product_id, :amount, :price, :creat_status)
  end
  
end