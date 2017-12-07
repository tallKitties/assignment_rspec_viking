require 'viking'
require 'weapons/axe'
require 'weapons/bow'
require 'weapons/fists'

RSpec.describe Viking do

  let(:viking){Viking.new('Ben')}

  describe '#initialize' do

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

  describe '#pick_up_weapon' do
    
    let(:bow){Bow.new}
    let(:axe){Axe.new}
   
    it "should keep the weapon it picks up" do
      viking.pick_up_weapon(bow)
      expect(viking.weapon).to eq(bow)
    end

    it "should not be able to pickup non-weapons" do
      expect{viking.pick_up_weapon('nope')}.to raise_error(RuntimeError)
    end

    it "should replace the old weapon when picking up a new one" do
      [bow, axe].each do |weapon|
        viking.pick_up_weapon(weapon)
        expect(viking.weapon).to eq(weapon)
      end
    end
  end

  describe '#drop_weapon' do

    let(:ben){Viking.new('Ben', 100, 10, Bow.new)}

    it "should drop the weapon" do
      ben.drop_weapon
      expect(ben.weapon).to be_nil
    end

  end

end