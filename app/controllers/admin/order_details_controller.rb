class Admin::OrderDetailsController < Admin::ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if @order_detail.creat_status == "now_at_work"
      @order.update(order_status: 2)
    elsif @order.order_details.count == @order.order_details.where(creat_status: "created").count
    @order.update(order_status: 3)
    end
    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:creat_status)
  end

end
