require 'rails_helper'

describe 'when visiting a companys\' jobs index page' do
  scenario 'a user sees company name and job title' do
    company = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 90,
                               city: 'Denver')

    visit company_path(company)

    expect(current_path).to eq("/companies/#{company.id}/jobs")
    expect(page).to have_content(company.name)
    expect(page).to have_content(job.title)
  end
end
