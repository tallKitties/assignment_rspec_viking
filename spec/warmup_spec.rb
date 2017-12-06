require "warmup"

RSpec.describe Warmup do
  let(:warmup){Warmup.new}

  describe '#gets_shout' do

    it "should shout what it's given" do
      allow(warmup).to receive(:gets).and_return('test')
      allow(warmup).to receive(:puts)
      expect(warmup.gets_shout).to eq('TEST')
    end
  end

  describe '#triple_size' do
    let(:arr){[1,2,3,4]}

    it "should return the array size * 3" do
      expect(warmup.triple_size(arr)).to eq(12)
    end
  end

  describe '#calls_some_methods' do
    let(:string){'test string'}
    let(:up_string){'TEST STRING'}
    let(:reverse_string){string.reverse}
    let(:string_id){string.object_id}

    it "should UPCASE the given string" do
      expect(string).to receive(:upcase!).and_return(up_string)

      allow(string).to receive(:reverse!).and_return(string)

      warmup.calls_some_methods(string)
    end

    it "should reverse the given string" do
      allow(string).to receive(:upcase!).and_return(string)

      expect(string).to receive(:reverse!).and_return(reverse_string)

      warmup.calls_some_methods(string)
    end

    it "should return a different object" do
      expect(warmup.calls_some_methods(string).object_id).not_to eq(string_id)
    end
  end
end