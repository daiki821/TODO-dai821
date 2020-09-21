class Task < ApplicationRecord
  has_one_attached :eyecatch
  belongs_to :user
  belongs_to :board
  validates :title, presence: true
  validates :content, presence: true
end
