class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end
  
  def create
    task = Task.new(task_params)
    task.save!
    redirect_to tasks_url, notice: "タスク「#{task.name}」を登録しました。"
    # 上記は、下のように二行で書くのと同じ意味
    # flash[:notice] = "タスク「#{task.name}」を登録しました。"
    # redirect_to tasks_url
  end

  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
    
  end
  
  private
  
  def task_params
    params.require(:task).permit(:name, :description)
  end
end
