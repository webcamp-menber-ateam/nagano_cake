class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to request.referer, notice: "ジャンルを追加しました。"
    else
      @genres = Genre.all
      render 'index'
    end

  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path, notice: "ジャンルを編集しました。"
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
