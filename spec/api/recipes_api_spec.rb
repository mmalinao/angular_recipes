require 'rails_helper'
require 'rack/test'

def app
  AngularRecipes::Application
end

describe RecipesAPI, type: :request do

  describe 'GET /api/v1/recipes' do
    subject(:do_get) { get '/api/v1/recipes' }

    let!(:recipe) { FactoryGirl.create(:recipe) }
    before(:each) { do_get }

    it 'should return list of recipes' do
      expect(json_response).to include represent_as_json(recipe)
    end
  end
end
