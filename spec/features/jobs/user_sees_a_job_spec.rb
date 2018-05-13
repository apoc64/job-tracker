require 'rails_helper'

describe 'User sees a specific job' do
  scenario 'for a specific company' do
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

    expect(page).to have_content(job.city)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
  end

  scenario 'user can click link of job to be directed to its show page' do
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

    visit company_path(company)

    click_link(job.title)

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content(job.city)
  end
end
