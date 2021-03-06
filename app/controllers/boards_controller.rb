class BoardsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    @tasks = @board.tasks.all
  end


  def new
    @board = current_user.boards.build
  end


  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to root_path, notice: 'boardを作成できました'
    else
      flash.now[:error] = 'boradの作成に失敗しました'
      render :new
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to root_path, notice:'boardを変更しました'
    else
      flash.now[:error] = 'boardの変更に失敗しました'
      render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[ :id])
    if board.destroy
      redirect_to root_path, notice:'boardを削除しました'
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :content)
  end

end