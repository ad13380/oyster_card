require_relative 'journey'

class Oystercard
  attr_reader :balance

  MAX_BALANCE = 90
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(value)
    fail "Maximum balance of £#{MAX_BALANCE} has been exceeded" if max_balance?(value)

    @balance += value
  end

  def touch_in(entry_station)
    fail "Balance is bellow minimum amount of £#{MIN_FARE}" if min_balance?

    deduct(PENALTY_FARE) if in_journey?
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    in_journey? ? deduct(@journey.fare) : deduct(PENALTY_FARE)
    @journey.end(exit_station)
  end

  def journey_history
    @journey.history
  end

  private

  def in_journey?
    @journey.in_journey?
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
