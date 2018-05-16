class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :destroy

  def self.grouped_with_average_interest_level
    group_company_names.order('average_level_of_interest DESC')
                       .average(:level_of_interest)
                       .take(3)
  end

  def self.grouped_with_highest_interest_level
    group_interest_level.order('average_level_of_interest DESC')
                        .average(:level_of_interest)
                        .take(3)
  end

  def self.grouped_with_city
  cities_array = select(:city).group(:city).count.to_a
  cities_array.sort_by do |city|
    -city[1]
  end
  end

  def self.group_company_names
    joins(:company).group(:name)
  end

  def self.group_interest_level
    group(:title, :level_of_interest)
  end
end
