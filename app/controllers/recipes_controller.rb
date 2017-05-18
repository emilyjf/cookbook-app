class RecipesController < ApplicationController
  def index
    if session[:count] == nil
      session[:count] = 0
    end

    session[:count] += 1
    @visit_count = session[:count]

    @recipes = Recipe.all
    sort_attribute = params[:sort]
    if sort_attribute
      @recipes = Recipe.all.order(sort_attribute)
    end
  end



  def show
    recipe_id = params[:id]
    @recipe = Recipe.find_by(id: recipe_id)
  end

  def new
    
  end

  def create
    recipe = Recipe.new(
                        title: params[:title],
                        ingredients: params[:ingredients],
                        prep_time: params[:prep_time],
                        directions: params[:directions],
                        user_id: current_user.id
                        )
    recipe.save
    flash[:success] = "Recipe successfully created."
    redirect_to "/recipes/#{ recipe.id }"
  end


  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.assign_attributes(
                             title: params[:title],
                             ingredients: params[:ingredients],
                             directions: params[:directions],
                             prep_time: params[:prep_time]
                             )
    recipe.save
    flash[:success] = "Recipe successfully updated."
    redirect_to "/recipes/#{ recipe.id }"
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    flash[:warning] = "Recipe destroyed."
    redirect_to "/"
  end
end








