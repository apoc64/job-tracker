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

  scenario 'user sees all comments for a job on its show page' do
    category = Category.create!(title: 'Technology')
    company  = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 80,
                               city: 'Denver',
                               category: category)
    comment1 = job.comments.create!(content: 'Type for 14 hours')
    comment2 = job.comments.create!(content: 'File Paperwork')

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

    fill_in 'comment[content]', with: comment_text
    click_on 'Save'

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content(Comment.last.content)
  end

  scenario 'user sees all comments on job page in ascending order' do
    category = Category.create!(title: 'Technology')
    company  = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer',
                               level_of_interest: 80,
                               city: 'Denver',
                               category: category)
    comment1 = job.comments.create!(content: 'First Comment')
    comment2 = job.comments.create!(content: 'Second Comment')
    comment3 = job.comments.create!(content: 'Third Comment')

    visit company_job_path(company, job)

    within(".comment_#{comment3.id}") do
      expect(page).to have_content(comment3.created_at)
    end

    within(".comment_#{comment2.id}") do
      expect(page).to have_content(comment2.created_at)
    end

    within(".comment_#{comment1.id}") do
      expect(page).to have_content(comment1.created_at)
    end
  end
end
