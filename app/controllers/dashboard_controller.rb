class DashboardController < ApplicationController
  def index
    @companies_grouped_with_avg_interest_lvl = Job.grouped_with_average_interest_level
    @jobs_grouped_by_interest_level = Job.grouped_with_highest_interest_level
  end
end
