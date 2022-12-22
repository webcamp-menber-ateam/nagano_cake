class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit]

  def index
    @address = Address.new
    @addresses = current_customer.addresses.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to request.referer, notice: "配送先の情報を登録しました。"
    else
      @addresses = current_customer.addresses.all
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先の情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to request.referer, notice: "配送先の情報を削除しました。"
  end
  
  def lookup_address
    binding.pry
    address = PostCodeIndex.instance.lookup(params[:customer][:delivery_postcode])
    if address.nil?
      redirect_to request.referer, notice: "該当する郵便番号はありませんでした"
    else
      @address = Address.new(address_params)
      @address.postcode = address[:post_code]
      @address.address = address[:prefecture] + address[:city] + address[:street]
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:postcode, :name, :address)
  end

  def ensure_correct_customer
    @address = Address.find(params[:id])
    unless @address.customer == current_customer
      redirect_to addresses_path
    end
  end

end