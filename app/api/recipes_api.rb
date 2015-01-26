class RecipesAPI < Grape::API

  helpers do
    def permitted_params
      ActionController::Parameters.new(params).permit(:name, :instructions)
    end
  end

  resource :recipes do

    get do
      if params[:keywords]
        present Recipe.keywords(params[:keywords]), with: Recipe::Entity
      else
        present Recipe.all, with: Recipe::Entity
      end
    end

    get ':id' do
      present Recipe.find(params[:id]), with: Recipe::Entity
    end

    post do
      present Recipe.create!(permitted_params), with: Recipe::Entity
    end

    put ':id' do
      recipe = Recipe.find(params[:id])
      recipe.update_attributes!(permitted_params)
      present recipe, with: Recipe::Entity
    end
  end
end
