class Admin::HomesController < ApplicationController
  
  def top
    @orders = Order.list 
  end
end
