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

    message = 'ESPN was successfully deleted!'
    expect(page).to_not have_link(company.name)
    expect(page).to have_content(message)
  end

  scenario 'a user can view contacts for the company' do
    company = Company.create!(name: 'ESPN')
    contact1 = company.contacts.create!(full_name: "Steve", position: "Superhero", email: "bob@bob.bob")
    contact2 = company.contacts.create!(full_name: "Steph", position: "Supervillian", email: "wob@wob.wob")

    visit company_path(company)

    expect(page).to have_content(contact1.full_name)
    expect(page).to have_content(contact1.position)
    expect(page).to have_content(contact1.email)
    expect(page).to have_content(contact2.full_name)
    expect(page).to have_content(contact2.position)
    expect(page).to have_content(contact2.email)
  end

  scenario 'a user can create contacts for the company' do
    company = Company.create!(name: 'ESPN')

    visit company_path(company)

    name = 'Steve'
    position = 'superhero'
    email = 'bob@bob.bob'
    fill_in 'contact[full_name]', with: name
    fill_in 'contact[position]', with: position
    fill_in 'contact[email]', with: email

    # save_and_open_path
    click_on "Create Contact"

    expect(current_path).to eq(company_path(company))
    within('.contacts') do
      expect(page).to have_content(name)
      expect(page).to have_content(name)
      expect(page).to have_content(name)
    end
  end


end
