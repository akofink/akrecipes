class RecipesController < ApplicationController
  def create
    @recipe = Recipe.new(recipe_params)
    recipes_form

    if @recipe.save
      flash[:success] = "The recipe was successfully created"
      redirect_to @recipe
    else
      flash[:error] = @recipe.errors.full_messages
      render :new
    end
  end

  def destroy
    if recipe.destroy
      flash[:info] = 'The recipe was successfully deleted'
      redirect_to :root
    else
      flash[:error] = 'The recipe could not be deleted.'
      redirect_back
    end
  end

  def edit
    set_recipe
    recipes_form
  end

  def filter
    @recipes = paginated_recipes.with_keyword params[:term]
    render partial: 'all'
  end

  def index
    paginated_recipes
  end

  def new
    @recipe = Recipe.new
  end

  def show
    set_recipe
  end

  def update
    @recipe = recipe
    if @recipe.update(recipe_params)
      flash[:success] = "The recipe was successfully updated"
      redirect_to @recipe
    else
      flash[:error] = @recipe.errors.full_messages
      render :edit
    end
  end

  private

  def recipes
    @recipes = (
      (user.recipes if user) ||
      (Recipe.all)
    ).order(:title)
  end

  def paginated_recipes
    @recipes = recipes.page(params[:page] || 1)
  end

  def set_recipe
    @recipe ||= Recipe.find_by id: params[:id]
    @images ||= @recipe.try(:images)+ [ Image.new ]
    @recipe
  end
  alias_method :recipe, :set_recipe

  def user
    @user ||= User.find_by id: params[:user_id]
  end

  def recipe_params
    params
      .require(:recipe)
      .permit(
    :title,
    :body,
    :user_id,
    images_attributes: [
      :id,
      :data,
      :user_id,
      :recipe_id
    ]
    )
  end

  def action_allowed?(args = params)
    case args[:action]
    when 'create', 'new'
      current_user
    when 'index', 'show', 'add_image', 'filter'
      true
    when 'edit', 'update', 'destroy', 'delete'
      current_user && recipe.user == current_user
    end
  end

  private def recipes_form
    @markdown_tip = <<tip
You can use <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet">markdown</a> here.
<br>
<br>
Example:
<br>
<br>
# Ingredients
<br>
- yams
<br>
- alfalfa paste
<br>
<br>
# Directions
<br>
1. This thing
<br>
2. The next thing
tip
  end
end
