require 'rails_helper'

describe Category, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should have_many(:jobs) }
  end
end
