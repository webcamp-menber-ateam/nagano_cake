class Admin::HomesController < ApplicationController

  def top
    @orderdetails = OrderDetail.all
  end
end
