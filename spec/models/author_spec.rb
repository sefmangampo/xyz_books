describe 'validations' do
  context 'when first_name is blank' do
    let(:author) { Author.new(last_name: 'Doe') }

    it 'is not valid' do
      expect(author).to_not be_valid
      expect(author.errors[:first_name]).to include("can't be blank")
    end
  end

  context 'when last_name is blank' do
    let(:author) { Author.new(first_name: 'John') }

    it 'is not valid' do
      expect(author).to_not be_valid
      expect(author.errors[:last_name]).to include("can't be blank")
    end
  end
end
