require 'rails_helper'


describe 'User deletes existing job' do
  scenario 'when clicking delete link for a job on jobs index page' do
    name              = 'ESPN'
    title             = 'Developer'
    level_of_interest = 80
    city              = 'Denver'
    category          = Category.create!(title: 'Technology')
    company           = Company.create!(name: name)
    job = company.jobs.create!(title: title,
                               level_of_interest: level_of_interest,
                               city: city,
                               category: category)
    
    visit company_jobs_path(company)

    within(".job_#{job.id}") do
      click_link 'Delete'
    end

    expect(page).to have_content("#{job.title} was successfully deleted!")
    expect(page).to_not have_link(job.title)
  end

  scenario 'when clicking delete link for a job on job show page' do
    name              = 'ESPN'
    title             = 'Developer'
    level_of_interest = 80
    city              = 'Denver'
    category          = Category.create!(title: 'Technology')
    company           = Company.create!(name: name)
    job = company.jobs.create!(title: title,
                               level_of_interest: level_of_interest,
                               city: city,
                               category: category)

    visit company_job_path(company, job)

    click_link 'Delete'

    expect(page).to have_content("#{job.title} was successfully deleted!")
    expect(page).to_not have_link(job.title)
  end
end
