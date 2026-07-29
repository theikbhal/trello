class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def show
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to @board, notice: "Board created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: "Board updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy
    redirect_to root_path, notice: "Board deleted."
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :description)
  end
end