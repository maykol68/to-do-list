class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:filter] == "completed"
      @tasks = Task.where(completed: true)
    elsif params[:filter] == "pending"
      @tasks = Task.where(completed: false)
    else
      @tasks = Task.all
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "tasks has been created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task actualizada correctamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task eliminada correctamente"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed, :due_date)
  end
end

