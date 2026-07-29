class CommentsController < ApplicationController
  before_action :set_board
  before_action :set_card

  def create
    @comment = @card.comments.new(comment_params)
    if @comment.save
      redirect_to [@board, @card], notice: "Comment added."
    else
      redirect_to [@board, @card], alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @comment = @card.comments.find(params[:id])
    @comment.destroy
    redirect_to [@board, @card], notice: "Comment deleted."
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_card
    @card = @board.cards.find(params[:card_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end