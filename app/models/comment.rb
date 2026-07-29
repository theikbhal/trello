class Comment < ApplicationRecord
  belongs_to :card
  validates :body, presence: true
end