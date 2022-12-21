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
    @orders = Order.where(customer_id: params[:customer_id]).page(params[:page])
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :email, :is_customer_deleted)
  end
end
