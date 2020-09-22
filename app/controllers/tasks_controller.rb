class TasksController < ApplicationController
  before_action :authenticate_user!

  def show
   
  end

  
  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build(user_id: current_user.id)
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params.merge(user_id: current_user.id))
    
    if @task.save
      redirect_to board_path(@task.board), notice: 'taskを作成しました'
    else 
      flash.now[:error] = 'taskを作成できませんでした'
      render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :eyecatch)
  end
end