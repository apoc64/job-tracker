require 'rails_helper'

describe 'User visits job in a city page' do
  scenario 'user sees a list of jobs in that city' do
    category = Category.create(title: 'Developer')
    company = Company.create!(name: 'ESPN')
    job1 = category.jobs.create!(title: 'Sr Dev',
                               level_of_interest: 30,
                               city: 'Denver',
                               company: company)
    job2 = category.jobs.create!(title: 'Jr Dev',
                               level_of_interest: 40,
                               city: 'New York',
                               company: company)

    visit '/jobs?location=Denver'
    # save_and_open_page
    message = "All Jobs for Denver"
    expect(page).to have_content(message)
    expect(page).to have_content(job1.title)
    expect(page).to_not have_content(job2.title)
  end
end
