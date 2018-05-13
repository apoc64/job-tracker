require 'rails_helper'

describe Category, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
  end
end
