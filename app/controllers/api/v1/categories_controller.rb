# frozen-string-literal: true

module Api
  module V1
    class CategoriesController < Api::V1::BaseController
      def index
        @categories = Category.
          select(:id, :title, :updated_at).
          all
      end
    end
  end
end
