require 'rails_helper'

describe 'User creates a new company' do
  scenario 'when clicking create button after filling in company name' do
    visit new_company_path

    name = 'ESPN'
    fill_in 'company[name]', with: name
    click_button 'Create'

    expect(current_path).to eq(company_jobs_path(Company.first.id))
    expect(page).to have_content(name)
    expect(Company.count).to eq(1)
  end

  scenario 'a user can navigate to the new company page' do
    visit companies_path

    click_link 'Create New Company'

    expect(current_path).to eq(new_company_path)
  end

  describe 'user cannot create a company with no name' do
    scenario 'when user clicks link to create with blank company name' do
      visit new_company_path

      click_button 'Create'

      error = 'You must enter a name for your company'
      expect(current_path).to eq(new_company_path)
      expect(page).to have_content(error)
    end
  end
end
