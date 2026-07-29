class SearchController < ApplicationController
  def index
    @query = params[:q]
    if @query.present?
      @boards = Board.search(@query)
      @lists = List.search(@query)
      @cards = Card.search(@query)
    else
      @boards = []
      @lists = []
      @cards = []
    end
  end
end