class Journey
  attr_reader :history, :entry_station, :exit_station

  def initialize
    @history = []
  end

  def start(entry_station)
    open_journey_entry(entry_station, nil)
    @in_journey = true
  end

  def end(exit_station)
    open_journey_entry(nil, exit_station) unless in_journey?
    close_journey_entry(exit_station)
    @in_journey = false
  end

  def in_journey?
    !!@in_journey
  end

  def fare
    @fare = Oystercard::MIN_FARE
  end

  private

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
