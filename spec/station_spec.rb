require 'station'

describe Station do
  let(:station_class) { Station }
  let(:station) { Station.new('Homerton', 2) }

  describe '#initialize' do
    it 'is expected to respond to #new with 2 arguments' do
      expect(station_class).to respond_to(:new).with(2).arguments
    end
  end

  describe '#name' do
    it 'is expected to respond to #name' do
      expect(station).to respond_to(:name)
    end

    it 'returns station name' do
      expect(station.name).to eq 'Homerton'
    end
  end

  describe '#zone' do
    it 'is expected to respond to #zone' do
      expect(station).to respond_to(:zone)
    end

    it 'returns station name' do
      expect(station.zone).to eq 2
    end
  end
end
