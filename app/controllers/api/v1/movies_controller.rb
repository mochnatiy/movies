class Api::V1::MoviesController < ApplicationController
  def index
    render json: Movie.all.order('id DESC')
  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: movie
    else
      render(
        json: { errors: movie.errors.full_messages.join(',') }.to_json,
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    Movie.destroy(params[:id])
  end

  def update
    movie = Movie.find(params[:id])
    movie.update_attributes(movie_params)
    render json: movie
  end

  private

  def movie_params
    params.require(:movie).permit(:id, :title, :description)
  end
end
