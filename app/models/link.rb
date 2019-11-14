class Link < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :votes

  validates :title, presence: true
  validates :url, presence: true

  def upvotes
    votes.sum(:upvote)
  end

  def downvotes
    votes.sum(:downvote)
  end
end
