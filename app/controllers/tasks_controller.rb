class TasksController < ApplicationController
  before_action :authenticate_user!

  def new 
    @board = board.find(params[:board_id])
    @task = current_user.tasks.build.

  end

  def create

    board = board.find(params[:board_id])
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to root_path, notice: 'taskを作成しました'
    else
      flash.now[:error] = 'taskが作成できませんでした'
      render :new
    end
  end



  private

  def task_params
    params.require(:task).permit(:title, :content,)
  end

end