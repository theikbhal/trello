class CardsController < ApplicationController
  before_action :set_board

  def new
    @list = @board.lists.find(params[:list_id]) if params[:list_id]
    @card = Card.new
  end

  def create
    @list = @board.lists.find(params[:list_id])
    @card = @list.cards.new(card_params)
    @card.position = (@list.cards.maximum(:position) || 0) + 1
    if @card.save
      redirect_to @board, notice: "Card added."
    else
      redirect_to @board, alert: @card.errors.full_messages.to_sentence
    end
  end

  def show
    @card = @board.cards.find(params[:id])
    @comment = @card.comments.new
  end

  def edit
    @card = @board.cards.find(params[:id])
    @all_tags = Tag.all.order(:name)
  end

  def update
    @card = @board.cards.find(params[:id])
    if @card.update(card_params)
      if params[:card][:tag_ids].present?
        @card.tag_ids = params[:card][:tag_ids].reject(&:blank?)
      end
      redirect_to @card.list.board, notice: "Card updated."
    else
      redirect_to @card.list.board, alert: @card.errors.full_messages.to_sentence
    end
  end

  def destroy
    @card = @board.cards.find(params[:id])
    @board = @card.list.board
    @card.destroy
    redirect_to @board, notice: "Card deleted."
  end

  def move
    @card = @board.cards.find(params[:id])
    target_board_id = params[:board_id]
    target_list_id = params[:list_id]
    new_position = params[:position].to_i

    if target_list_id.present?
      if target_board_id.present? && target_board_id.to_i != @board.id
        target_board = Board.find(target_board_id)
        target_list = target_board.lists.find(target_list_id)
      else
        target_list = @board.lists.find(target_list_id)
      end
      @card.update!(list: target_list)
    end

    if new_position > 0
      @card.insert_at(new_position)
    end

    redirect_to @card.list.board
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def card_params
    params.require(:card).permit(:title, :description, :deadline, :assignee, tag_ids: [])
  end
end