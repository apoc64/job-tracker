require 'rails_helper'

describe 'User sees a specific job' do
  scenario 'on its show page' do
    category = Category.create!(title: 'Technology')
    company  = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 80,
                               city: 'Denver',
                               category: category)

    visit company_job_path(company, job)

    expect(page).to have_content(company.name)
    expect(page).to have_content(job.city)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
    expect(page).to have_content(job.category.title)
  end

  scenario 'user can click link of job to be directed to its show page' do
    category = Category.create!(title: 'Technology')
    company  = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 80,
                               city: 'Denver',
                               category: category)

    visit company_path(company)

    click_link(job.title)

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content(job.title)
  end

  scenario 'user sees all comments for a job on its show page' do
    category = Category.create!(title: 'Technology')
    company  = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 80,
                               city: 'Denver',
                               category: category)
    comment1 = job.job_comments.create!(content: 'Type for 14 hours')
    comment2 = job.job_comments.create!(content: 'File Paperwork')

    visit company_job_path(company, job)

    expect(page).to have_content(comment1.content)
    expect(page).to have_content(comment1.created_at)
    expect(page).to have_content(comment1.updated_at)
    expect(page).to have_content(comment2.content)
    expect(page).to have_content(comment2.created_at)
    expect(page).to have_content(comment2.updated_at)
  end

  scenario 'user can create a new comment for a job on its show page' do
    comment_text = 'File Things'
    category = Category.create!(title: 'Technology')
    company  = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 80,
                               city: 'Denver',
                               category: category)

    visit company_job_path(company, job)

    fill_in 'job_comment[content]', with: comment_text
    click_on 'Save'

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content(JobComment.last.content)
  end

  scenario 'user sees all comments on job page in ascending order' do
    category = Category.create!(title: 'Technology')
    company  = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 80,
                               city: 'Denver',
                               category: category)
    comment1 = job.job_comments.create!(content: 'First Comment')
    comment2 = job.job_comments.create!(content: 'Second Comment')
    comment3 = job.job_comments.create!(content: 'Third Comment')

    visit company_job_path(company, job)

    within('.job_comments') do
      expect(comment1).to eq(job.job_comments.last)
      expect(comment2).to eq(job.job_comments[1])
      expect(comment3).to eq(job.job_comments.first)
    end
  end
end
