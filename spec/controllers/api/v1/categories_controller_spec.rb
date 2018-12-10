require 'rails_helper'

RSpec.describe Api::V1::CategoriesController do
  render_views

  describe 'GET index', type: :request do
    context 'when categories exist' do
      let!(:category1) { create(:category, title: 'Horror') }
      let!(:category2) { create(:category, title: 'Comedy') }
      let!(:category3) { create(:category) }

      before do
        get(
          '/api/v1/categories.json'
        )
      end

      specify 'response status should be 200' do
        expect(response.status).to eq(200)
      end

      specify 'a JSON with with categories shoud be returned' do
        categories = JSON.parse(response.body).map!(&:symbolize_keys)

        expect(categories).to eql(
          [
            {
              id: category1.id,
              title: category1.title
            },
            {
              id: category2.id,
              title: category2.title
            },
            {
              id: category3.id,
              title: category3.title
            }
          ]
        )
      end
    end
  end
end
