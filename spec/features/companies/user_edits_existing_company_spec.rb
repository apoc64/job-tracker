require 'rails_helper'

describe 'User edits an existing company' do
  scenario 'when clicking edit link for a company' do
    name = 'ESPN'
    new_name =  'EA Sports'
    company = Company.create!(name: name)
    visit edit_company_path(company)

    fill_in 'company[name]', with: new_name
    click_button 'Update'

    expect(current_path).to eq(company_jobs_path(Company.first.id))
    expect(page).to have_content(new_name)
    expect(page).to_not have_content(name)
  end

  scenario 'when submitting with an empty name it reloads with a message' do
    company = Company.create!(name: 'ESPN2')
    visit edit_company_path(company)

    fill_in 'company[name]', with: ''
    click_button 'Update'

    error = 'Company name cannot be blank'
    expect(current_path).to eq(edit_company_path(company))
    expect(page).to have_content(error)
  end
end
