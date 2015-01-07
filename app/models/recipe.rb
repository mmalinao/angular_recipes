class Recipe < ActiveRecord::Base
  include Grape::Entity::DSL

  validates :name, presence: true

  entity :id, :name, :instructions
end
