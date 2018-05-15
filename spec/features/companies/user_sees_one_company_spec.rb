require 'rails_helper'

describe 'when visiting a company show page' do
  scenario 'a user sees company name' do
    company = Company.create!(name: 'ESPN')

    visit company_path(company)

    expect(page).to have_content(company.name)
  end

  scenario 'a user can edit the company' do
    company = Company.create!(name: 'ESPN')

    visit company_path(company)

    click_link "Edit"

    expect(current_path).to eq(edit_company_path(company))
  end
end
