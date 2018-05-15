require 'rails_helper'

describe 'User creates a new company' do
  scenario 'a user can navigate to create company page' do
    visit companies_path

    click_link 'add a new company'

    expect(current_path).to eq(new_company_path)
  end

  scenario 'when clicking create button after filling in company name form' do
    name = 'ESPN'

    visit new_company_path

    fill_in 'company[name]', with: name
    click_button 'Create'

    expect(current_path).to eq(company_path(Company.last))
    expect(page).to have_content(name)
  end

  describe 'user cannot create a company without a name' do
    scenario 'when user clicks link to create with blank company name' do
      error = 'You must enter a name for your company'

      visit new_company_path

      click_button 'Create'

      expect(current_path).to eq(new_company_path)
      expect(page).to have_content(error)
    end
  end
end
