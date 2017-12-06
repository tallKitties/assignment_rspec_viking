require 'weapons/bow'

RSpec.describe Bow do

  let(:bow){Bow.new}
  
  describe '#initialize' do
    
    it 'should allow user to read @arrows' do
      expect{bow.arrows}.not_to raise_error
    end

    it 'should default to starting with 10 arrows' do
      expect(bow.arrows).to eq(10)
    end

    it 'should start with 7 arrows this time' do
      bow = Bow.new(7)
      expect(bow.arrows).to eq(7)
    end

  end

  describe '#use' do
    before do
      allow(bow).to receive(:puts)
    end

    it "should use 1 arrow each time it's \"used\"" do
      bow.use
      expect(bow.arrows).to eq(9)
    end

    it "should raise an error if no arrows are left" do
      bow = Bow.new(0)
      expect{bow.use}.to raise_error(RuntimeError)
    end
  end
end