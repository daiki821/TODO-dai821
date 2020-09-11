class TasksController < ApplicationController
  before_action :authenticate_user!

  def new 
    board = Board.find(params[:board_id])
    @task = board.tasks.build

  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    
    
    binding.pry
    
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