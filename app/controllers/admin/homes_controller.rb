class Admin::HomesController < Admin::ApplicationController

  def top
    @orders = Order.page(params[:page]).order(created_at: "DESC")
  end
end
