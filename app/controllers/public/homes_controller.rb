class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @products = Product.order('updated_at').limit(4)
  end

  def about
  end
end
