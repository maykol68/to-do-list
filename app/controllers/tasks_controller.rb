class TasksController < ApplicationController

    def index
        @tasks = Task.all
        
    end

    def create
        @tasks = Task.new(tasks_params)

        if @tasks.save
            redirect_to tasks_path, notice: "tasks has been created"
        else 
            render :new, status: :unprocessable_entity
        end
    end

    private 

    def tasks_params
        params.require(:task).permit(:title, :description, :completed)
    end 
end