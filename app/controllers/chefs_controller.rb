class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id
      flash[:success] = "Your account has been created successfully!"
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  def edit
  end
  
  def update
    if @chef.update(chef_params)
      flash[:success] = "Account has been updated successfully!"
      redirect_to recipes_path
    else
      render 'edit'
    end
  end
  
  private
  
    def chef_params
      params.require(:chef).permit(:username, :email, :password)
    end
    
    def set_chef
      @chef = Chef.find(params[:id])
    end
  
    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can only edit your profile!"
        redirect_to root_path
      end
    end
  
end
