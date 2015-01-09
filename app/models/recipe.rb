class Recipe < ActiveRecord::Base
  include Grape::Entity::DSL

  validates :name, presence: true

  entity :id, :name, :instructions

  def self.keywords(str)
    arr = str.split(' ').map{ |x| "%#{x}%" }
    Recipe.where('name ilike any ( array[?] )', arr)
  end
end
