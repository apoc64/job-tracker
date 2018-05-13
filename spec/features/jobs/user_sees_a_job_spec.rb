require 'rails_helper'

describe 'User sees a specific job' do
  scenario 'for a specific company' do
    company = Company.create!(name: 'ESPN')
    job     = company.jobs.create!(title: 'Developer',
                                   level_of_interest: 70,
                                   city: 'Denver')

    visit company_job_path(company, job)

    expect(page).to have_content(job.city)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
  end

  scenario 'user can click link of job to be directed to its show page' do
    company = Company.create!(name: 'ESPN')
    job     = company.jobs.create!(title: 'Developer',
                                   level_of_interest: 70,
                                   city: 'Denver')

    visit company_path(company)

    click_link(job.title)

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content(job.city)
  end
end
