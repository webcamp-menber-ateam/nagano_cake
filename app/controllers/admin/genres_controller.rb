class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to request.referer, notice: "ジャンルを追加しました。"
  end

  def edit
  end

  def update
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
