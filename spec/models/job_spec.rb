require 'rails_helper'

describe Job, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:level_of_interest)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:title)}
  end

  describe 'relationships' do
    it {should belong_to(:company)}
    it {should belong_to(:category)}

    it 'has many job comments' do
      job = Job.new(title: 'Software',
                    level_of_interest: 70,
                    description: 'Wahooo')
      expect(job).to respond_to(:job_comments)
    end

  end
end
