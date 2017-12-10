require 'viking'
require 'weapons/axe'
require 'weapons/bow'
require 'weapons/fists'

RSpec.describe Viking do
  let(:ben) { Viking.new('Ben') }
  let(:bow) { Bow.new }
  let(:axe) { Axe.new }
  let(:fists) { Fists.new }

  describe '#initialize' do
    it "sets it's name to 'Ben' when I pass that on init" do
      expect(ben.name).to eq('Ben')
    end

    it "sets it's health to 92 when I pass that on init" do
      ben = Viking.new('Ben', 92)
      expect(ben.health).to eq(92)
    end

    it "can't alter health after it's been set" do
      expect { ben.health = 50 }.to raise_error(NoMethodError)
    end

    it "starts without a weapon" do
      expect(ben.weapon).to be_nil
    end
  end

  describe '#pick_up_weapon' do
    it "should keep the weapon it picks up" do
      ben.pick_up_weapon(bow)
      expect(ben.weapon).to eq(bow)
    end

    it "should not be able to pickup non-weapons" do
      expect { ben.pick_up_weapon('nope') }.to raise_error(RuntimeError)
    end

    it "should replace the old weapon when picking up a new one" do
      [bow, axe].each do |weapon|
        ben.pick_up_weapon(weapon)
        expect(ben.weapon).to eq(weapon)
      end
    end
  end

  describe '#drop_weapon' do
    let(:ben) { Viking.new('Ben', 100, 10, bow) }

    it "should drop the weapon" do
      ben.drop_weapon
      expect(ben.weapon).to be_nil
    end
  end

  context 'during attacks...' do
    before { allow(ben).to receive(:puts) }
    let(:damage) { 10 }

    describe '#receive_attack' do
      it "loses health when it's attacked" do
        ben.receive_attack(damage)
        expect(ben.health).to eq(90)
      end

      it "calls the take_damage method" do
        expect(ben).to receive(:take_damage)
        ben.receive_attack(damage)
      end
    end
  end
end