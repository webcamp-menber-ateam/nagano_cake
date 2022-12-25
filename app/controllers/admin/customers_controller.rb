class Admin::CustomersController < Admin::ApplicationController

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer), notice: "会員情報を編集しました。"
  end

  def orders
    @customer = Customer.find(params[:customer_id])
    search = params[:search]
    if search == "waiting_for_payment"
      @orders = Order.page(params[:page]).where(customer_id: params[:customer_id]).where(order_status: 0).order(created_at: "DESC")
    elsif search == "payment_confirmation"
      @orders = Order.page(params[:page]).where(customer_id: params[:customer_id]).where(order_status: 1).order(created_at: "DESC")
    elsif search == "now_at_work"
      @orders = Order.page(params[:page]).where(customer_id: params[:customer_id]).where(order_status: 2).order(created_at: "DESC")
    elsif search == "shipping_preparation"
      @orders = Order.page(params[:page]).where(customer_id: params[:customer_id]).where(order_status: 3).order(created_at: "DESC")
    elsif search == "sent"
      @orders = Order.page(params[:page]).where(customer_id: params[:customer_id]).where(order_status: 4).order(created_at: "DESC")
    else
      @orders = Order.page(params[:page]).where(customer_id: params[:customer_id]).order(created_at: "DESC")
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :email, :is_customer_deleted)
  end
end
