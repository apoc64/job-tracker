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

  scenario 'a user can delete the company' do
    company = Company.create!(name: 'ESPN')

    visit company_path(company)

    click_link "Delete"

    expect(current_path).to eq(companies_path)

    expect(page).to_not have_link(company.name)
    expect(page).to have_content('ESPN was successfully deleted!')
  end


end
