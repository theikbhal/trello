class Card < ApplicationRecord
  belongs_to :list
  has_one :board, through: :list
  has_many :comments, dependent: :destroy
  has_many :card_tags, dependent: :destroy
  has_many :tags, through: :card_tags

  validates :title, presence: true

  acts_as_list scope: :list

  def self.search(query)
    where("title ILIKE :q OR description ILIKE :q", q: "%#{query}%")
  end
end