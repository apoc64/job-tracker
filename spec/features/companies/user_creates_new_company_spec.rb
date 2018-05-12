require 'rails_helper'

describe 'User creates a new company' do
  scenario 'when clicking create button after filling in company name' do
    visit new_company_path

    fill_in 'company[name]', with: 'ESPN'
    click_button 'Create'

    expect(current_path).to eq("/companies/#{Company.last.id}/jobs")
    expect(page).to have_content('ESPN')
    expect(Company.count).to eq(1)
  end
end
