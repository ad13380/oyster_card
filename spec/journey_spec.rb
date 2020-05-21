require 'journey'

describe Journey do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { subject }
  let(:journey_in_process) { subject.start(entry_station) }
  let(:journey_complete) { journey_in_process ; subject.end(exit_station) }

  describe '#start' do
    it { is_expected.to respond_to(:start).with(1).argument }

    it 'takes the entry station and stores it in a hash' do
      journey_in_process
      expect(journey.history.last[:"entry station"]).to eq entry_station
    end
  end

  describe '#end' do
    it { is_expected.to respond_to(:end).with(1).argument }

    it 'takes the exit station and stores it in a hash' do
      journey_complete
      expect(journey.history.last[:"exit station"]).to eq exit_station
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'does not start in a journey' do
      expect(journey).not_to be_in_journey
    end

    it 'sets the card to be in journey after entering station' do
      journey_in_process
      expect(journey).to be_in_journey
    end

    it 'sets the card to not be in journey after exiting station' do
      journey_complete
      expect(journey).not_to be_in_journey
    end
  end

  describe '#history' do
    it { is_expected.to respond_to(:history) }

    it "is empty by default" do
      expect(journey.history).to be_empty
    end

    it 'returns the entry and exit stations of recorded journeys' do
      journey_complete
      expect(journey.history).to eq(
        [
          {
            :"entry station" => entry_station,
            :"exit station" => exit_station
          }
        ]
      )
    end
  end

  describe '#fare' do
    it 'returns minimum fare' do
      expect(journey.fare).to eq Oystercard::MIN_FARE
    end
  end
end
