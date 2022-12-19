class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

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
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to request.referer, notice: "配送先の情報を削除しました。"
  end

  private

  def address_params
    params.require(:address).permit(:postcode, :name, :address)
  end
end
