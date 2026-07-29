class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(:name)
    render json: @tags
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_back fallback_location: root_path, notice: "Tag created."
    else
      redirect_back fallback_location: root_path, alert: @tag.errors.full_messages.to_sentence
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end