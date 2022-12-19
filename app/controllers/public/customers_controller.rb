class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to my_page_customers_path
    else
      render "edit"
    end
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_customer_deleted: true)
    reset_session
    flash[:notice] = "退会が完了しました。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :email)
  end
end
