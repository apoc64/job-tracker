require 'rails_helper'

describe 'User edits an existing job after clicking edit link for a job' do
  scenario 'clicks submit button with filled in forms' do
    old_title             = 'Developer'
    old_level_of_interest = 80
    old_city              = 'Denver'
    new_title             = 'CEO'
    new_description       = 'Not so fun!'
    new_level_of_interest = 30
    new_city              = 'New York City'
    old_category          = Category.create!(title: 'Technology')
    company               = Company.create!(name: 'ESPN')
    new_category          = Category.create!(title: 'Awesome')
    job = company.jobs.create!(title: old_title,
                               level_of_interest: old_level_of_interest,
                               city: old_city,
                               category: old_category)

    visit edit_company_job_path(company, job)

    fill_in 'job[title]',             with: new_title
    fill_in 'job[description]',       with: new_description
    fill_in 'job[level_of_interest]', with: new_level_of_interest
    fill_in 'job[city]',              with: new_city
    select new_category.title, from: job[new_category]

    click_button 'Update'

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content(new_title)
    expect(page).to have_content(new_description)
    expect(page).to have_content(new_level_of_interest)
    expect(page).to have_content(new_city)
    expect(page).to have_content(new_category.title)

    expect(page).to_not have_content(old_title)
    expect(page).to_not have_content(old_level_of_interest)
    expect(page).to_not have_content(old_city)
    expect(page).to_not have_content(old_category.title)
  end

  describe 'user clicks submit button with empty forms' do
    it 'should reload page with error' do
      category = Category.create!(title: 'Technology')
      company  = Company.create!(name: 'ESPN')
      job = company.jobs.create!(title: 'Developer',
                                 level_of_interest: 80,
                                 city: 'Denver',
                                 category: category)

      visit edit_company_job_path(company, job)

      fill_in 'job[title]',             with: ''
      fill_in 'job[description]',       with: ''
      fill_in 'job[level_of_interest]', with: ''
      fill_in 'job[city]',              with: ''

      click_button 'Update'

      error = 'Fill out all required fields before you update!'
      expect(current_path).to eq(edit_company_job_path(company, job))
      expect(page).to have_content(error)
    end
  end
end
