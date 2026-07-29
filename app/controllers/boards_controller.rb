class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy, :export]

  def index
    redirect_to root_path
  end

  def show
    @lists = @board.lists
    @all_tags = Tag.all.order(:name)
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

  def export
    render json: {
      board: {
        name: @board.name,
        description: @board.description,
        created_at: @board.created_at,
        updated_at: @board.updated_at
      },
      lists: @board.lists.map { |l|
        {
          name: l.name,
          position: l.position,
          cards: l.cards.map { |c|
            {
              title: c.title,
              description: c.description,
              position: c.position,
              deadline: c.deadline,
              assignee: c.assignee,
              tags: c.tags.pluck(:name),
              comments: c.comments.map { |cm|
                { body: cm.body, created_at: cm.created_at }
              }
            }
          }
        }
      }
    }
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :description)
  end
end