# frozen_string_literal: true

module Api
  module V1
    class MoviesController < Api::V1::BaseController
      def index
        @movies = Movie.
          includes(:category).
          active.
          order('id DESC')
      end

      def create
        @movie = Movie.new(movie_params)

        if @movie.save
          render(action: 'show')
        else
          render(
            status: :unprocessable_entity,
            json: { errors: @movie.errors.full_messages.join(',') }.to_json
          )
        end
      end

      def destroy
        movie = Movie.find(params[:id])
        movie.destroy

        if movie.destroyed?
          head :no_content
        else
          render(
            status: :unprocessable_entity,
            json: { errors: movie.errors.full_messages.join(',') }.to_json
          )
        end
      end

      def update
        @movie = Movie.find(params[:id])

        if @movie.update(movie_params)
          render(action: 'show')
        else
          render(
            status: :unprocessable_entity,
            json: { errors: @movie.errors.full_messages.join(',') }.to_json
          )
        end
      end

      private

      def movie_params
        params.require(:movie).permit(:id, :title, :description, :category_id)
      end
    end
  end
end
