require 'rails_helper'
require 'rack/test'

describe RecipesAPI, type: :request do

  describe 'GET /api/v1/recipes' do
    let!(:recipe) { FactoryGirl.create(:recipe) }
    subject(:do_get) { get "/api/v1/recipes#{keywords}" }

    context 'when no keyword parameters given' do
      let(:keywords) { '' }

      it 'should return list of all recipes' do
        do_get
        expect(json_response).to include represent_as_json(recipe)
      end
    end

    context 'when keyword parameter given' do
      let(:keywords) { '?keywords=brussel' }

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

  describe 'GET /api/v1/recipes/:id' do
    let(:recipe) { FactoryGirl.create(:recipe) }
    subject(:do_get) { get "/api/v1/recipes/#{recipe.id}" }

    it 'should return recipe given id' do
      do_get
      expect(json_response).to eq represent_as_json(recipe)
    end

    context 'when recipe does not exist' do
      let(:recipe) { double(id: 1) }

      it 'should return 404' do
        do_get
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'POST /api/v1/recipes' do
    subject(:do_post) { post '/api/v1/recipes', params }

    let(:new_recipe) { Recipe.last }
    let(:params) { FactoryGirl.attributes_for(:recipe) }

    it 'should create a new Recipe' do
      expect { do_post }.to change { Recipe.count }.by(1)
    end

    it 'should create a new Recipe with given parameters' do
      do_post
      expect(new_recipe).to have_attributes params
    end

    it 'should return new recipe as json' do
      do_post
      expect(json_response).to eq represent_as_json(new_recipe)
    end

    it 'should return 201 status' do
      do_post
      expect(last_response.status).to eq 201
    end

    context 'when invalid params' do
      let(:params) { FactoryGirl.attributes_for(:recipe, name: nil) }

      it 'should not create a new Recipe' do
        expect { do_post }.to_not change { Recipe.count }
      end

      it 'should return 422 status' do
        do_post
        expect(last_response.status).to eq 422
      end

      it 'should set error message' do
        do_post
        expect(json_response['error']).to_not be_nil
      end
    end
  end
end
