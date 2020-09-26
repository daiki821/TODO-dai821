class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:task_id])
    @comment = @task.comments.build(user_id: current_user.id)
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.find(params[:task_id])
    @comment = @task.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to board_task_path(board_id: @task.board_id, id: @task.id), notice: 'commentを作成しました'
    else
      flash.now[:error] = 'commentが作成できませんでした'
      render :new
    end
  end


  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end