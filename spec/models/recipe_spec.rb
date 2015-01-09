require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { is_expected.to validate_presence_of :name }

  describe Recipe::Entity do
    subject { Recipe::Entity }

    it { is_expected.to represent :id }
    it { is_expected.to represent :name }
    it { is_expected.to represent :instructions }
  end

  describe '.keyword' do
    subject { Recipe.keywords(str) }

    let!(:recipe_1) { FactoryGirl.create(:recipe, name: 'Baked Potato') }
    let!(:recipe_2) { FactoryGirl.create(:recipe, name: 'Brussel Sprouts') }

    context 'when recipe exist with matching keyword' do
      let(:str) { 'baked' }

      it 'should include matching recipe' do
        is_expected.to include recipe_1
      end

      it 'should exclude other recipes' do
        is_expected.to_not include recipe_2
      end
    end

    context 'when multiple recipes exist with matching keywords' do
      let(:str) { 'baked sprouts' }

      it 'should include matching recipes' do
        is_expected.to include recipe_1, recipe_2
      end
    end
  end
end
