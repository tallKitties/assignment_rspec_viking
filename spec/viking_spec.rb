require 'viking'

RSpec.describe Viking do

  describe '#initialize' do
    let(:viking){Viking.new('Ben')}

    it "sets it's name to 'Ben' when I pass that on init" do
      expect(viking.name).to eq('Ben')
    end

    it "sets it's health to 92 when I pass that on init" do
      viking = Viking.new('Ben', 92)
      expect(viking.health).to eq(92)
    end

    it "can't alter health after it's been set" do
      expect{viking.health=50}.to raise_error(NoMethodError)
    end

    it "starts without a weapon" do
      expect(viking.weapon).to be_nil
    end

  end

end