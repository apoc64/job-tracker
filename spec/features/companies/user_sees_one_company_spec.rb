require 'rails_helper'

describe 'when visiting a companys\' jobs index page' do
  scenario 'a user sees company name and job title' do
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

    expect(current_path).to eq(company_jobs_path(Company.first.id))
    expect(page).to have_content(company.name)
    expect(page).to have_content(job.title)
  end
end
