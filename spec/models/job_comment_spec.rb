require 'rails_helper'

describe JobComment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'relationships' do
    it { should belong_to(:job) }
  end
end
