require 'rails_helper'
require 'rack/test'

describe RecipesAPI, type: :request do

  describe 'GET /api/v1/recipes' do
    let!(:recipe) { FactoryGirl.create(:recipe) }

    context 'when no keyword parameters given' do
      let(:do_get) { get '/api/v1/recipes' }

      it 'should return list of all recipes' do
        do_get
        expect(json_response).to include represent_as_json(recipe)
      end
    end

    context 'when keyword parameter given' do
      let(:do_get) { get '/api/v1/recipes?keywords=brussel' }

      context 'and matching recipe(s) exist' do
        let!(:recipe) { FactoryGirl.create(:recipe, name: 'Brussel Sprouts') }

        it 'should return matching recipe(s)' do
          do_get
          expect(json_response).to include represent_as_json(recipe)
        end
      end

      context 'and no matching recipe(s) exist' do
        let!(:recipe) { FactoryGirl.create(:recipe, name: 'Baked Potato') }

        it 'should return no recipes' do
          do_get
          expect(json_response).to eq []
        end
      end
    end
  end
end
