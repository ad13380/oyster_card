require 'oyster_card'

describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:card) { subject }
  let(:card_touch_in) { subject.top_up(Oystercard::MIN_FARE) ; subject.touch_in(entry_station) }
  let(:card_completed_journey) { card_touch_in ; subject.touch_out(exit_station) }

  describe '#balance' do
    it { is_expected.to respond_to :balance }

    it "returns a starting balance of 0" do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up card balance using passed argument as value' do
      card.top_up(80)
      expect(card.balance).to eq 80
    end

    it 'raises an error when balance is over maximum limit' do
      card.top_up(Oystercard::MAX_BALANCE)
      expect { card.top_up(1) }.to raise_error "Maximum balance of £#{Oystercard::MAX_BALANCE} has been exceeded"
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it "raises an error when trying to touch in with a balance of less than the minimum fare" do
      expect{ card.touch_in(entry_station) }.to raise_error "Balance is bellow minimum amount of £#{Oystercard::MIN_FARE}"
    end

    it 'deducts penalty fare if entering a station while in journey' do
      card_touch_in
      expect { card.touch_in(entry_station) }.to change{ card.balance }.by(- Oystercard::PENALTY_FARE)
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'deducts fare when touching out of a completed journey' do
      card_touch_in
      expect { card.touch_out(exit_station) }.to change{ card.balance }.by(- Oystercard::MIN_FARE)
    end

    it 'deducts penalty fare if exiting a station while not in journey' do
      expect { card.touch_out(exit_station) }.to change{ card.balance }.by(- Oystercard::PENALTY_FARE)
    end
  end
end
