class Link < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true
end
