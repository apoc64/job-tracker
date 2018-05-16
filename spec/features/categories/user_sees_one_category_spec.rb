require 'rails_helper'

describe 'User visits all categories page' do
  scenario 'a user can navigate to a category' do
    category = Category.create(title: 'Developer')
    visit categories_path

    click_link '0 jobs'

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
  scenario 'it can delete a job' do
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

    within(".job_#{job1.id}") do
      click_link 'Delete'
    end

    within("main") do
      expect(page).to_not have_content(job1.title)
    end
  end

  scenario 'it can go to edit job page' do
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

    within(".job_#{job1.id}") do
      click_link 'Edit'
    end

    expect(current_path).to eq(edit_company_job_path(job1.company, job1))
    expect(page).to_not have_content(job1.title)
  end
end
