require 'viking'
require 'weapons/axe'
require 'weapons/bow'
require 'weapons/fists'

RSpec.describe Viking do
  let(:ben) { Viking.new('Ben') }
  let(:bow) { Bow.new }
  let(:axe) { Axe.new }
  let(:fists) { Fists.new }
  before { allow(ben).to receive(:puts) }

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

    describe '#attack' do
      let(:john) { Viking.new('John') }
      let(:john_dub) do
        instance_double(
          'John',
          name: 'John',
          receive_attack: nil
        )
      end

      before do
        allow(john).to receive(:puts)
        allow(john_dub).to receive(:puts)
      end

      context 'regardless of weapons' do
        before do
          allow(ben).to receive(:damage_dealt).and_return(10)
        end

        it 'causes damage to the viking being attacked' do
          ben.attack(john)
          expect(john.health).to eq(90)
        end

        it 'calls "take_damage" on the viking being attacked' do
          expect(john).to receive(:take_damage)
          ben.attack(john)
        end
      end

      context 'without a weapon' do
        it 'calls damage_with_fists if no weapon is used' do
          expect(ben).to receive(:damage_with_fists).and_return(2.5)
          ben.attack(john_dub)
        end

        it 'uses Fists multiplier * strength to set damage dealt' do
          ben.attack(john)
          expect(john.health).to eq(97.5)
        end
      end

      context 'with a weapon' do
        let(:ben) { Viking.new('Ben', 100, 10, bow) }
        let(:ben_empty) { Viking.new('Ben', 100, 10, Bow.new(0)) }

        it 'calls damage_with_weapon if weapon is used' do
          expect(ben).to receive(:damage_with_weapon).and_return(10)
          ben.attack(john_dub)
        end

        it 'uses Weapon multiplier * strength to set damage dealt' do
          ben.attack(john)
          expect(john.health).to eq(80)
        end

        it 'uses fists when no arrows are left' do
          expect(ben_empty).to receive(:damage_with_fists).and_return(2.5)
          ben_empty.attack(john_dub)
        end
      end

      context 'killing a viking' do
        let(:john) { Viking.new('John', 2.5) }
        it 'should raise an error' do
          allow(ben).to receive(:damage_dealt).and_return(2.5)
          expect { ben.attack(john) }.to raise_error(RuntimeError)
        end
      end
    end
  end
end