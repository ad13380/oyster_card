class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey

  MAX_BALANCE = 90
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey = []
  end

  def top_up(value)
    fail "Maximum balance of £#{MAX_BALANCE} has been exceeded" if max_balance?(value)

    @balance += value
  end

  def touch_in(entry_station)
    fail "Balance is bellow minimum amount of £#{MIN_FARE}" if min_balance?

    @exit_station = nil
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    add_journey
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def add_journey
    @journey << {:"entry station" => entry_station, :"exit station" => exit_station}
  end

  def deduct(value)
    @balance -= value
  end

  def max_balance?(top_up_value)
    @balance + top_up_value > MAX_BALANCE
  end

  def min_balance?
    @balance < MIN_FARE
  end
end
