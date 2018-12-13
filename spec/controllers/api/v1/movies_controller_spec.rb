# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController do
  render_views

  describe 'GET index', type: :request do
    context 'when movies exist' do
      let!(:category1) { create(:category, title: 'Horror') }
      let!(:category2) { create(:category, title: 'Comedy') }

      let!(:movie1) do
        create(:movie,
          title: 'Horror movie 1',
          category: category1,
          description: 'Description 1'
        )
      end

      let!(:movie2) do
        create(:movie,
          title: 'Horror movie 2',
          category: category2,
          description: 'Description 2'
        )
      end

      before do
        get(
          '/api/v1/movies.json'
        )
      end

      specify 'response status should be 200' do
        expect(response.status).to eq(200)
      end

      specify 'a JSON with movies shoud be returned' do
        movies = JSON.parse(response.body).
          each { |elm| elm.delete('created_at') }.
          map(&:symbolize_keys)

        expected_result = [
          {
            id: movie1.id,
            title: movie1.title,
            description: movie1.description,
            category_id: movie1.category.id,
            category_title: movie1.category.title,
          },
          {
            id: movie2.id,
            title: movie2.title,
            description: movie2.description,
            category_id: movie2.category.id,
            category_title: movie2.category.title,
          },
        ]

        expected_result.sort! { |x, y| y[:id] <=> x[:id] }

        expect(movies).to eql(expected_result)
      end
    end

    context 'when some movies are removed' do
      let!(:category1) { create(:category, title: 'Horror') }
      let!(:category2) { create(:category, title: 'Comedy') }

      let!(:movie1) do
        create(:movie,
          title: 'Horror movie 1',
          category: category1,
          description: 'Description 1'
        )
      end

      let!(:movie2) do
        create(:movie,
          title: 'Horror movie 2',
          category: category2,
          description: 'Description 2',
          is_deleted: true
        )
      end

      before do
        get(
          '/api/v1/movies.json'
        )
      end

      specify 'response status should be 200' do
        expect(response.status).to eq(200)
      end

      specify 'a JSON with active movies shoud be returned' do
        movies = JSON.parse(response.body).
          each { |elm| elm.delete('created_at') }.
          map(&:symbolize_keys)

        expected_result = [
          {
            id: movie1.id,
            title: movie1.title,
            description: movie1.description,
            category_id: movie1.category.id,
            category_title: movie1.category.title,
          },
        ]

        expect(movies).to eql(expected_result)
      end
    end
  end

  describe 'POST create', type: :request do
    context 'in case of request with valid data' do
      let!(:category) { create(:category, title: 'Horror') }

      let(:title) { 'The Conjuring' }
      let(:description) { 'A good horror movie by James Wan' }

      before do
        @existing_movies_count = Movie.count

        post(
          '/api/v1/movies.json',
          params: {
            movie: {
              category_id: category.id,
              title: title,
              description: description,
            },
          }
        )

        @movie = Movie.last
      end

      specify 'response status be 200' do
        expect(response.status).to eq(200)
      end

      specify 'amount of movies should be increased' do
        expect(Movie.count).to eq(@existing_movies_count + 1)
      end

      specify 'attributes of new movie should match the request' do
        expect(@movie.title).to eq(title)
        expect(@movie.description).to eq(description)
        expect(@movie.category_id).to eq(category.id)
      end

      specify 'a JSON with new movie should be returned' do
        expect(
          JSON.parse(response.body).except('created_at').symbolize_keys
        ).to eq(
          id: @movie.id,
          title: @movie.title,
          description: @movie.description,
          category_id: category.id,
          category_title: category.title
        )
      end
    end
  end

  describe 'PUT update', type: :request do
    context 'in case of valid request' do
      let!(:category) { create(:category, title: 'Horror') }

      let!(:movie) do
        create(:movie,
          title: 'The Conjuring',
          description: 'A good horror movie by James Wan',
          category: category
        )
      end

      let(:old_title) { movie.title }
      let(:new_description) { 'A very good horror movie by James Wan' }

      before do
        put(
          "/api/v1/movies/#{movie.id}.json",
          params: {
            movie: {
              category_id: category.id,
              title: movie.title,
              description: new_description,
            },
          }
        )

        movie.reload
      end

      specify 'response status should be 200' do
        expect(response.status).to eq(200)
      end

      specify 'attributes from request should be changed, all other - not' do
        expect(movie.title).to eq(old_title)
        expect(movie.description).to eq(new_description)
        expect(movie.category_id).to eq(category.id)
      end

      specify 'a JSON with updated movie should be returned' do
        expect(
          JSON.parse(response.body).except('created_at').symbolize_keys
        ).to eq(
          id: movie.id,
          title: old_title,
          description: new_description,
          category_id: category.id,
          category_title: category.title
        )
      end
    end
  end

  describe 'DELETE destroy', type: :request do
    context 'in case of valid request' do
      let!(:category) { create(:category, title: 'Horror') }

      let!(:movie1) do
        create(:movie,
          title: 'The Conjuring',
          description: 'A good horror movie by James Wan',
          category: category
        )
      end

      let!(:movie2) do
        create(:movie,
          title: 'Insidious',
          description: 'Another horror movie by James Wan',
          category: category
        )
      end

      let(:old_title) { movie2.title }
      let(:old_description) { movie2.description }

      before do
        @existing_movies = Movie.count
        @active_movies = Movie.active.count

        delete(
          "/api/v1/movies/#{movie2.id}.json"
        )
      end

      specify 'should return status 204' do
        expect(response.status).to eq(204)
      end

      specify 'amount of active movies should be decreased' do
        expect(Movie.active.count).to eq(@active_movies - 1)
      end

      specify 'total amount of movies should not be changed' do
        expect(Movie.count).to eq(@existing_movies)
      end

      specify 'removed movie remains in database' do
        expect { movie2.reload }.not_to raise_error
      end

      specify 'attribute is_deleted should be changed to true' do
        movie2.reload

        expect(movie2.title).to eq(old_title)
        expect(movie2.description).to eq(old_description)
        expect(movie2.category_id).to eq(category.id)
        expect(movie2.is_deleted).to be true
      end

      specify 'should return no JSON' do
        expect(response.body).to be_empty
      end
    end
  end
end
