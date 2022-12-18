class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @genres = Genre.all
  end

  def new
    @product = Product.new
  end

  def create
  end

  def edit
  end

  def update
  end

end
