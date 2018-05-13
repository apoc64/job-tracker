require 'rails_helper'

describe Contact, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:email) }
  end

  describe 'relationships' do
    it { should belong_to(:company) }
  end
end
