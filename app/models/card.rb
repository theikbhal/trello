class Card < ApplicationRecord
  belongs_to :list
  has_one :board, through: :list

  validates :title, presence: true

  acts_as_list scope: :list
end
