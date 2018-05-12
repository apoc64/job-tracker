require 'rails_helper'

describe 'When on the company index page' do
  scenario 'a user sees all the companies' do
    company1 = Company.create!(name: 'ESPN')
    company2 = Company.create!(name: 'Disney')

    visit companies_path

    expect(page).to have_content(company1.name)
    expect(page).to have_content(company2.name)
  end
end
