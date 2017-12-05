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
end