class RecipesAPI < Grape::API

  resource :recipes do

    get do
      if params[:keywords]
        present Recipe.keywords(params[:keywords]), with: Recipe::Entity
      else
        present Recipe.all, with: Recipe::Entity
      end
    end
  end
end
