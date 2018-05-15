class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :job_comments, -> { order(created_at: :desc) }, dependent: :destroy
end
