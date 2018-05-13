require 'rails_helper'

describe 'User creates a new job' do
  xscenario 'a user can navigate to the create job page for a company' do
    company = Company.create!(name: name)

    visit company_jobs_path(company)

    click_link 'Create New Job'

    expect(current_path).to eq(new_company_job_path(company))
  end

  scenario 'after filling out form fields' do
    name              = 'ESPN'
    title             = 'Developer'
    description       = 'So fun!'
    city              = 'Denver'
    level_of_interest = 80
    company           = Company.create!(name: name)

    visit new_company_job_path(company)

    fill_in 'job[title]',             with: title
    fill_in 'job[description]',       with: description
    fill_in 'job[level_of_interest]', with: level_of_interest
    fill_in 'job[city]',              with: city

    click_button 'Create'

    job = company.jobs.last

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content(name)
    expect(page).to have_content(title)
    expect(page).to have_content(description)
    expect(page).to have_content(level_of_interest)
    expect(page).to have_content(city)
  end

  scenario 'when a user tries to submit an empty job form' do
    error   = 'Enter information into all fields before submitting!'
    name    = 'ESPN'
    company = Company.create!(name: name)

    visit new_company_job_path(company)

    fill_in 'job[title]',             with: ''
    fill_in 'job[description]',       with: ''
    fill_in 'job[level_of_interest]', with: ''
    fill_in 'job[city]',              with: ''

    click_button 'Create'

    expect(current_path).to eq(new_company_job_path(company))
    expect(page).to have_content(error)
  end
end
