require 'rails_helper'

describe 'User sees a dashboard page when visiting /dashboard' do
  it 'should see a header with title of the app Job Tracker' do
    dashboard_message = 'Job Tracker'

    visit dashboard_path

    expect(page).to have_content(dashboard_message)
  end

  it 'should see top companies by average level of interest in their job(s)' do
    label     = 'Top Companies by Interest'
    category1 = Category.create!(title: 'Technology')
    company1  = Company.create!(name: 'ESPN')
    company1.jobs.create!(title: 'Developer',
                          level_of_interest: 80,
                          city: 'Denver',
                          category: category1)
    company1.jobs.create!(title: 'QA Analyst',
                          level_of_interest: 20,
                          city: 'New York City',
                          category: category1)
    category2 = Category.create!(title: 'Astrology')
    company2  = Company.create!(name: 'Stars')
    company2.jobs.create!(title: 'Reader',
                          level_of_interest: 50,
                          city: 'Seattle',
                          category: category2)
    company2.jobs.create!(title: 'Lily Layer',
                          level_of_interest: 35,
                          city: 'Denver',
                          category: category2)
    visit dashboard_path

    expect(page).to have_content(label)
    expect(page).to have_content(company1.name)
    expect(page).to have_content(company2.name)
    expect(page).to have_content(company1.jobs.grouped_with_average_interest_level.first.last)
    expect(page).to have_content(company1.jobs.grouped_with_average_interest_level.last.last)
  end

  it 'should see top jobs by highest level of interest' do
    label     = 'Jobs by Interest'
    category1 = Category.create!(title: 'Technology')
    company1  = Company.create!(name: 'ESPN')
    job1 = company1.jobs.create!(title: 'Developer',
                                 level_of_interest: 80,
                                 city: 'Denver',
                                 category: category1)
    job2 = company1.jobs.create!(title: 'QA Analyst',
                                 level_of_interest: 20,
                                 city: 'New York City',
                                 category: category1)
    category2 = Category.create!(title: 'Astrology')
    company2  = Company.create!(name: 'Stars')
    job3 = company2.jobs.create!(title: 'Reader',
                                 level_of_interest: 50,
                                 city: 'Seattle',
                                 category: category2)
    job4 = company2.jobs.create!(title: 'Lily Layer',
                                 level_of_interest: 35,
                                 city: 'Denver',
                                 category: category2)
    visit dashboard_path

    expect(page).to have_content(label)
    expect(page).to have_content(job1.title)
    expect(page).to have_content(job3.title)
    expect(page).to have_content(job4.title)
    expect(page).to_not have_content(job2.title)
    expect(page).to have_content(Job.grouped_with_highest_interest_level.first.last)
    expect(page).to have_content(Job.grouped_with_highest_interest_level.last.last)
  end
end
