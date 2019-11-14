class Link < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :votes

  validates :title, presence: true
  validates :url, presence: true

  scope :trending, -> { order(trending: :desc) }
  scope :newest, -> { order(created_at: :desc) }

  def upvotes
    votes.sum(:upvote)
  end

  def downvotes
    votes.sum(:downvote)
  end

  def total_points
    upvotes - downvotes
  end

  def calc_trending
    points = upvotes - downvotes
    time_ago_in_hours = ((Time.now - created_at) / 3600).round
    score = trending(points, time_ago_in_hours)
  
    update_attributes(points: points, trending: score)
  end
  
  private
  
  def trending(points, time_ago_in_hours, gravity = 1.8)
    # one is subtracted from available points because every link by default has one point 
    # There is no reason for picking 1.8 as gravity, just an arbitrary value
    (points - 1) / (time_ago_in_hours + 2) ** gravity
  end

end
