require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    company = Company.create!(name: "ESPN")
    visit new_company_job_path(company)

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("80")
    expect(page).to have_content("Denver")
  end

  scenario 'when a user tries to submit an empty job form' do
    company = Company.create!(name: "ESPN")
    visit new_company_job_path(company)

    fill_in "job[title]", with: ""
    fill_in "job[description]", with: ""
    fill_in "job[level_of_interest]", with: 0
    fill_in "job[city]", with: ""

    click_button "Create"

    error = "You need to enter information into all form fields before submitting!"
    expect(current_path).to eq(new_company_job_path(company))
    expect(page).to have_content(error)
  end
end
