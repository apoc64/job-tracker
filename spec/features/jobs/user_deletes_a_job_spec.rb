require 'rails_helper'

describe 'User deletes existing job' do
  scenario 'when clicking delete link for a job' do
    company = Company.create(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 70,
                               city: 'Denver')
    visit company_job_path(company, job)

    click_link 'Delete'

    expect(page).to have_content("#{job.title} was successfully deleted!")
    expect(page).to_not have_link(job.title)
  end
end
