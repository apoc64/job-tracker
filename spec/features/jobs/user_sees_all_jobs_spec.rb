require 'rails_helper'

describe 'User sees all the jobs' do
  scenario 'for a specific company' do
    category = Category.create!(title: 'Technology')
    company  = Company.create!(name: 'ESPN')
    job1 = company.jobs.create!(title: 'Developer',
                                level_of_interest: 80,
                                city: 'Denver',
                                category: category)
    job2 = company.jobs.create!(title: 'QA Analyst',
                                level_of_interest: 70,
                                city: 'New York City',
                                category: category)

    visit company_path(company)

    expect(page).to have_content(company.name)
    expect(page).to have_content(job1.title)
    expect(page).to have_content(job2.title)
  end
end
