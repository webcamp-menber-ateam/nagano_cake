class Admin::HomesController < Admin::ApplicationController

  def top
    @order_details = OrderDetail.all
    search = params[:search]

    if search == "waiting_for_payment"
      @orders = Order.page(params[:page]).where(order_status: 0).order(created_at: "DESC")
    elsif search == "payment_confirmation"
      @orders = Order.page(params[:page]).where(order_status: 1).order(created_at: "DESC")
    elsif search == "now_at_work"
      @orders = Order.page(params[:page]).where(order_status: 2).order(created_at: "DESC")
    elsif search == "shipping_preparation"
      @orders = Order.page(params[:page]).where(order_status: 3).order(created_at: "DESC")
    elsif search == "sent"
      @orders = Order.page(params[:page]).where(order_status: 4).order(created_at: "DESC")
    else
      @orders = Order.page(params[:page]).order(created_at: "DESC")
    end
  end
end
