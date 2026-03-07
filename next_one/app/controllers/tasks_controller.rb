class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks.where(is_done: false).order(:due_on)
    @today_task = @tasks.first
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to root_path, notice: "タスクを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update(is_done: true)
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :due_on, :memo)
  end
end
