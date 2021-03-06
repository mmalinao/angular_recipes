require 'rails_helper'
require 'rack/test'

describe RecipesAPI, type: :request do

  describe 'GET /api/v1/recipes' do
    let!(:recipe) { FactoryGirl.create(:recipe) }
    subject(:do_request) { get "/api/v1/recipes#{keywords}" }

    context 'when no keyword parameters given' do
      let(:keywords) { '' }

      it 'should return list of all recipes' do
        do_request
        expect(json_response).to include represent_as_json(recipe)
      end
    end

    context 'when keyword parameter given' do
      let(:keywords) { '?keywords=brussel' }

      context 'and matching recipe(s) exist' do
        let!(:recipe) { FactoryGirl.create(:recipe, name: 'Brussel Sprouts') }

        it 'should return matching recipe(s)' do
          do_request
          expect(json_response).to include represent_as_json(recipe)
        end
      end

      context 'and no matching recipe(s) exist' do
        let!(:recipe) { FactoryGirl.create(:recipe, name: 'Baked Potato') }

        it 'should return no recipes' do
          do_request
          expect(json_response).to eq []
        end
      end
    end
  end

  describe 'GET /api/v1/recipes/:id' do
    let(:recipe) { FactoryGirl.create(:recipe) }
    subject(:do_request) { get "/api/v1/recipes/#{recipe.id}" }

    it 'should return recipe given id' do
      do_request
      expect(json_response).to eq represent_as_json(recipe)
    end

    context 'when recipe does not exist' do
      let(:recipe) { double(id: -1) }
      include_examples 'not found'
    end
  end

  describe 'POST /api/v1/recipes' do
    subject(:do_request) { post '/api/v1/recipes', params }

    let(:new_recipe) { Recipe.last }
    let(:params) { FactoryGirl.attributes_for(:recipe) }

    it 'should create a new Recipe' do
      expect { do_request }.to change { Recipe.count }.by(1)
    end

    it 'should create a new Recipe with given parameters' do
      do_request
      expect(new_recipe).to have_attributes params
    end

    it 'should return new recipe as json' do
      do_request
      expect(json_response).to eq represent_as_json(new_recipe)
    end

    it 'should return 201 status' do
      do_request
      expect(last_response.status).to eq 201
    end

    context 'when invalid params' do
      let(:params) { FactoryGirl.attributes_for(:recipe, name: nil) }

      include_examples 'invalid params'

      it 'should not create a new Recipe' do
        expect { do_request }.to_not change { Recipe.count }
      end
    end
  end

  describe 'PUT /api/v1/recipes/:id' do
    subject(:do_request) { put "/api/v1/recipes/#{recipe.id}", params }

    let!(:recipe) { FactoryGirl.create(:recipe) }
    let(:params) { FactoryGirl.attributes_for(:recipe) }

    it 'should update an existing Recipe' do
      expect { do_request }.to change { recipe.reload.attributes }
    end

    it 'should update an existing Recipe with given parameters' do
      do_request
      expect(recipe.reload).to have_attributes(params)
    end

    it 'should return updated Recipe as json' do
      do_request
      expect(json_response).to eq represent_as_json recipe.reload
    end

    context 'when Recipe does not exist' do
      let(:recipe) { double(id: -1) }
      include_examples 'not found'
    end

    context 'when invalid params' do
      let(:params) { FactoryGirl.attributes_for(:recipe, name: nil) }

      include_examples 'invalid params'

      it 'should not update an existing Recipe' do
        expect { do_request }.to_not change { recipe.reload.attributes }
      end
    end
  end
end
