class ListsController < ApplicationController
  before_action :set_board

  def new
    @list = @board.lists.new
  end

  def create
    @list = @board.lists.new(list_params)
    @list.position = (@board.lists.maximum(:position) || 0) + 1
    if @list.save
      redirect_to @board, notice: "List added."
    else
      redirect_to @board, alert: @list.errors.full_messages.to_sentence
    end
  end

  def edit
    @list = @board.lists.find(params[:id])
  end

  def update
    @list = @board.lists.find(params[:id])
    if @list.update(list_params)
      redirect_to @board, notice: "List updated."
    else
      redirect_to @board, alert: @list.errors.full_messages.to_sentence
    end
  end

  def destroy
    @list = @board.lists.find(params[:id])
    @list.destroy
    redirect_to @board, notice: "List deleted."
  end

  def move
    @list = @board.lists.find(params[:id])
    new_position = params[:position].to_i
    if new_position > 0
      @list.insert_at(new_position)
    end
    redirect_to @board
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end