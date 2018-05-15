require 'rails_helper'

describe 'when visiting a companys\' jobs index page' do
  scenario 'a user sees company name and job title' do
    company           = Company.create!(name: 'ESPN')

    visit company_path(company)

    expect(page).to have_content(company.name)
  end
end
