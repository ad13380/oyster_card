require_relative 'station'
require_relative 'oyster_card'

class Journey
  attr_reader :history, :entry_station, :exit_station, :fare

  def initialize
    @history = []
  end

  # make sure to deduct on touch in and touch out

  def start(entry_station)
    set_penatly
    open_journey_entry(entry_station, nil)
    @in_journey = true
  end

  def end(exit_station)
    set_fare
    open_journey_entry(nil, exit_station) unless in_journey?
    close_journey_entry(exit_station)
    @in_journey = false
  end

  def in_journey?
    !!@in_journey
  end

  private

  def set_fare
    in_journey? ? @fare = Oystercard::MIN_FARE : @fare = Oystercard::PENALTY_FARE
  end

  def set_penatly
    @fare = Oystercard::PENALTY_FARE
  end

  def open_journey_entry(journey_start, journey_end)
    @history << {
      :"entry station" => journey_start,
      :"exit station" => journey_end
    }
  end

  def close_journey_entry(journey_end)
    @history.last[:"exit station"] = journey_end
  end
end
