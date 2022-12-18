class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @genres = Genre.all
  end

  def new
    @product = Product.new
    @genre = Genre.all
  end

  def create
  end

  def edit
  end

  def update
  end

end
