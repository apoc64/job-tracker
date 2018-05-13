require 'rails_helper'

describe Contact, type: :model do
  describe 'validations' do
    context 'invalid without attributes' do
      it 'is invalid without a full_name' do
        company = Company.new(name: 'Turing')
        contact = Contact.new(position: 'Steve Jobs',
                              email: 'stevejobs@company.com',
                              company: company)
        expect(contact).to be_invalid
      end

      it 'is invalid without a position' do
        company = Company.new(name: 'Turing')
        contact = Contact.new(full_name: 'Steve Jobs',
                              email: 'stevejobs@company.com',
                              company: company)
        expect(contact).to be_invalid
      end

      it 'is invalid without a email' do
        company = Company.new(name: 'Turing')
        contact = Contact.new(full_name: 'Steve Jobs',
                              position: 'Developer',
                              company: company)
        expect(contact).to be_invalid
      end

      it 'is invalid without a company' do
        contact = Contact.new(full_name: 'Steve Jobs',
                              position: 'Developer',
                              email: 'stevejobs@company.com')
        expect(contact).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with a full name, position, email, and company' do
        company = Company.new(name: 'Turing')
        contact = Contact.new(full_name: 'Steve Jobs',
                              position: 'Developer',
                              email: 'stevejobs@company.com',
                              company: company)
        expect(contact).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'belongs to a company' do
      company = Company.new(name: 'Turing')
      contact = Contact.new(full_name: 'Software',
                            position: 'Developer',
                            email: 'stevejobs@company.com',
                            company: company)
      expect(contact).to respond_to(:company)
    end
  end
end
