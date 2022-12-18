class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @orderdetails = OrderDetail.where(order_id: @order.id)
    @total_price = 0
  end

end
