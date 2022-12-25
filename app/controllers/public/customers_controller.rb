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

  def lookup_address
    address = PostCodeIndex.instance.lookup(params[:customer][:postcode])
    if address.nil?
      redirect_to request.referer, alert: "該当する郵便番号はありませんでした"
    else
      session[:customer] = Customer.new(customer_params)
      session[:customer][:last_name] = params[:customer][:last_name]
      session[:customer][:first_name] = params[:customer][:first_name]
      session[:customer][:last_name_kana] = params[:customer][:last_name_kana]
      session[:customer][:first_name_kana] = params[:customer][:first_name_kana]
      session[:customer][:postcode] = address[:post_code]
      session[:customer][:address] = address[:prefecture] + address[:city] + address[:street]
      session[:customer][:phone_number] = params[:customer][:phone_number]
      session[:customer][:email] = params[:customer][:email]
      redirect_to request.referer
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :email)
  end
end
