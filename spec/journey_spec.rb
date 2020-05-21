require 'journey'
require 'station'

describe Journey do
  let(:entry_station) { Station.new('oxford circus', 1)}
  let(:exit_station) { Station.new('canary wharf', 2)}

  let(:journey) { subject }
  let(:journey_in_process) do
    subject.start(entry_station)
    subject
  end

  let(:journey_complete) do
    journey_in_process.end(exit_station)
    journey_in_process
  end

  describe '#start' do
    it { is_expected.to respond_to(:start).with(1).argument }

    it 'takes the entry station and stores it in a hash' do
      expect(journey_in_process.history.last[:"entry station"]).to eq entry_station
    end
  end

  describe '#end' do
    it { is_expected.to respond_to(:end).with(1).argument }

    it 'takes the exit station and stores it in a hash' do
      expect(journey_complete.history.last[:"exit station"]).to eq exit_station
    end
  end

  describe '#in_journey' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'sets the card to be in jounrey after entering station' do
      expect(journey_in_process).to be_in_journey
    end

    it 'sets the card to not be in jounrey after exiting station' do
      expect(journey_complete).not_to be_in_journey
    end
  end

  describe '#history' do
    it { is_expected.to respond_to(:history) }

    it 'returns hash of completed journeys' do
      expect(journey_complete.history).to eq([{
          :"entry station" => entry_station,
          :"exit station" => exit_station
        }])
    end
  end

  describe '#fare' do
    it 'sets fare to minimum fare for a completed journey' do
      expect(journey_complete.fare).to eq Oystercard::MIN_FARE
    end

    it 'sets fare to penalty fare if exiting a station while not in journey' do
      journey.end(Station.new('stratford', 3))
      expect(journey.fare).to eq Oystercard::PENALTY_FARE
    end

    it 'sets fare to penalty fare if entering a station while in journey' do
      journey_in_process.start(Station.new('stratford', 3))
      expect(journey_in_process.fare).to eq Oystercard::PENALTY_FARE
    end
  end
end
