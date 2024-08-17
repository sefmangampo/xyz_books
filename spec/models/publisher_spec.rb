require 'rails_helper'

RSpec.describe Publisher, type: :model do
  describe 'validations' do
    context 'when name is blank' do
      let(:publisher) { Publisher.new(name: '') }

      it 'is not valid' do
        expect(publisher).to_not be_valid
        expect(publisher.errors[:name]).to include("can't be blank")
      end
    end

    context 'when name is present' do
      let(:publisher) { Publisher.new(name: 'Valid Publisher') }

      it 'is valid' do
        expect(publisher).to be_valid
      end
    end
  end
end
