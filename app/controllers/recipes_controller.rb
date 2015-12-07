class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(1)
    if @recipe.save
      flash[:success] = "Recipe successfully created!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe successfully updated!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end
  
  private
    
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
    
end