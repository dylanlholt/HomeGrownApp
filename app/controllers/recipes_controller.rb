class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :like]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end
  
  def show
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def edit
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    if @recipe.save
      flash[:success] = "Recipe successfully created!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe successfully updated!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end
  
  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful!"
      redirect_to :back
    else
      flash[:danger] = "Your can only vote once per recipe!"
      redirect_to :back
    end
  end
  
  private
    
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  
    def require_same_user
      if current_user != @recipe.chef
        flash[:danger] = "You can only edit your own recipes!"
        redirect_to recipes_path
      end
    end
    
    
    
end