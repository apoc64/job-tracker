require 'rails_helper'

describe JobComment, type: :model do
  describe 'validations' do
    context 'invalid without attributes' do
      it 'is invalid without content' do
        company = Company.new(name: 'Turing')
        category = Category.new(title: 'Software')
        job = Job.new(title: 'Developer',
                      level_of_interest: 40,
                      city: 'Denver',
                      company: company,
                      category: category)
        comment = job.job_comments.new
        expect(comment).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with content' do
        company = Company.new(name: 'Turing')
        category = Category.new(title: 'Software')
        job = Job.new(title: 'Developer',
                      level_of_interest: 40,
                      city: 'Denver',
                      company: company,
                      category: category)
        comment = job.job_comments.new(content: 'Eat Lunch')
        expect(comment).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'belongs to a job' do
      comment = JobComment.new(content: 'Eat Lunch')
      expect(comment).to respond_to(:job)
    end
  end
end
