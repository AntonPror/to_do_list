class CategoriesController < ApplicationController
  def index
    if logged_in?
      @categories = current_user.categories
    else
      raise "First log in"
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(params[:category])
    if @category.errors.blank?
        redirect_to "/categories"
    else
        render :action => :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    render :action => :new
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
    if @category.valid?
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def destroy
    Category.delete(params[:id])
    @id = params[:id]
    respond_to do |format|
      format.html {redirect_to :action => :index}
      format.js {render :action => :destroy}
    end
  end

  def show
    @tasks = Category.find(params[:id]).tasks
  end
end

