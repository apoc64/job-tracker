require 'rails_helper'

describe 'User visits all categories page' do
  scenario 'a user can navigate to a category' do
    category = Category.create(title: 'Developer')
    visit categories_path

    click_link 'Developer'

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(category.title)
  end
end

describe 'User visits single category page' do
  scenario 'it shows multiple jobs' do
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

    visit category_path(category)

    expect(page).to have_content(job1.title)
    expect(page).to have_content(job1.company.name)
    expect(page).to have_content(job1.city)
    expect(page).to have_content(job2.city)
    expect(page).to have_content(job2.title)
  end
end
