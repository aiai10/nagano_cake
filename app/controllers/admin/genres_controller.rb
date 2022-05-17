class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre =Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def update
    genre_edit = Genre.find(params[:id])
    genre_edit.update(genre_params)
    redirect_to admin_genres_path(genre_edit.id)
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
