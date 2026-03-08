class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks.where(is_done: false).where("due_on >= ?", Date.today).order(:due_on)
    @today_task = @tasks.first
    @overdue_tasks = current_user.tasks.where(is_done: false).where("due_on < ?", Date.today).order(:due_on)
    @completed_tasks = current_user.tasks.where(is_done: true).order(updated_at: :desc)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def edit
    @task = current_user.tasks.find(params[:id])
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

    if @task.update(task_params)
      redirect_to task_path(@task), notice: "タスクを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_status
    @task = current_user.tasks.find(params[:id])
    @task.update(is_done: !@task.is_done)
    redirect_to tasks_path
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:title, :due_on, :memo)
  end
end
