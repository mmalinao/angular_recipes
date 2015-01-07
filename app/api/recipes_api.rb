class RecipesAPI < Grape::API

  resource :recipes do

    get do
      present Recipe.all, with: Recipe::Entity
    end
  end
end
