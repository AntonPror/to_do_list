class TasksController < ApplicationController
  def index
    if logged_in?
      @tasks = current_user.tasks
    else
      raise "First log in"
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(params[:task])
    if @task.errors.blank?
      redirect_to "/tasks"
    else
      render :action => :new
    end
  end

  def destroy
    Task.delete(params[:id])
    redirect_to :action => :index
  end

  def edit
    @task = Task.find(params[:id])
    render :action => :new
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    if @task.valid?
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

end

