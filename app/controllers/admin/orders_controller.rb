class Admin::OrdersController < Admin::ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    @total_price = 0
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
      @order_details.update_all(creat_status: 1) if @order.order_status == "payment_confirmation"
    end
    redirect_to request.referer
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end

end
