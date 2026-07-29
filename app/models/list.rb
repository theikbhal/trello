class List < ApplicationRecord
  belongs_to :board
  has_many :cards, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true

  acts_as_list scope: :board

  def self.search(query)
    where("name ILIKE :q", q: "%#{query}%")
  end
end