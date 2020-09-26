class TasksController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

  def show
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
    @comments = @task.comments.all
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

  def edit
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])
  end

  def update
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:id])

    if @task.update(task_params.merge(user_id: current_user.id))
      redirect_to board_task_path(board_id: @task.board_id, id: @task.id), notice: 'taskを更新しました'
    else
      flash.now[:error] = 'taskを更新できませんでした'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:id])

    if task.destroy!
      redirect_to board_path(id: board.id), notice: 'taskを削除しました'
    end

  end


  private
  def task_params
    params.require(:task).permit(:title, :content, :eyecatch)
  end
end