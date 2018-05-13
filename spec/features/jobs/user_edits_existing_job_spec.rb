require 'rails_helper'

describe 'User edits an existing job after clicking edit link for a job' do
  scenario 'clicks submit button with filled in forms' do
    name                  = 'ESPN'
    title                 = 'Developer'
    level_of_interest     = 80
    city                  = 'Denver'
    new_title             = 'CEO'
    new_description       = 'Not so fun!'
    new_level_of_interest = 30
    new_city              = 'New York City'
    company               = Company.create!(name: name)
    category             = Category.create!(title: 'Awesome')
    new_category             = Category.create!(title: 'Lame')
    job = company.jobs.create!(title: title,
                               level_of_interest: level_of_interest,
                               city: city,
                               category: category)

    visit edit_company_job_path(company, job)

    fill_in 'job[title]',             with: new_title
    fill_in 'job[description]',       with: new_description
    fill_in 'job[level_of_interest]', with: new_level_of_interest
    fill_in 'job[city]',              with: new_city
    fill_in 'job[category]',          with: new_category

    click_button 'Update'

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content(new_title)
    expect(page).to_not have_content(title)
  end


  describe 'user clicks submit button with empty forms' do
    it 'should reload page with error' do
      name              = 'ESPN'
      title             = 'Developer'
      level_of_interest = 80
      city              = 'Denver'
      company           = Company.create!(name: name)
      category          = Category.create!(title: title)
      job = company.jobs.create!(title: title,
                                 level_of_interest: level_of_interest,
                                 city: city,
                                 category: category)

      visit edit_company_job_path(company, job)

      fill_in 'job[title]',             with: ''
      fill_in 'job[description]',       with: ''
      fill_in 'job[level_of_interest]', with: ''
      fill_in 'job[city]',              with: ''

      click_button 'Update'

      error = 'Fill out all fields before you update!'
      expect(current_path).to eq(edit_company_job_path(company, job))
      expect(page).to have_content(error)
    end
  end
end
