require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { is_expected.to validate_presence_of :name }

  describe Recipe::Entity do
    subject { Recipe::Entity }

    it { is_expected.to represent :id }
    it { is_expected.to represent :name }
    it { is_expected.to represent :instructions }
  end
end
