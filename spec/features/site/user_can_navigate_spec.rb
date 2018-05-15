require 'rails_helper'

describe 'User can navigate the site' do
  scenario 'a user can navigate to the companies page' do
    name = 'ESPN'
    company = Company.create!(name: name)

    visit company_jobs_path(company)

    click_link 'Companies'

    expect(current_path).to eq(companies_path)
  end

  scenario 'a user can navigate to categories' do
    visit companies_path

    click_link 'Categories'

    expect(current_path).to eq(categories_path)
  end
end
