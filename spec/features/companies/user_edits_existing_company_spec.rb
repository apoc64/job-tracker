require 'rails_helper'

describe 'User edits an existing company' do
  scenario 'when clicking edit link for a company' do
    company = Company.create!(name: 'ESPN')
    visit edit_company_path(company)

    fill_in 'company[name]', with: 'EA Sports'
    click_button 'Update'

    expect(current_path).to eq("/companies/#{company.id}/jobs")
    expect(page).to have_content('EA Sports')
    expect(page).to_not have_content('ESPN')
  end
end
