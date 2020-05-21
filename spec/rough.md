Oyster card class

##in_journey

#entry_station
(probably keep as is, just need to keep the @entry_station = entry_station)

#exit_station
(probably keep as is, just need to keep the @exit_station = exit_station)

##fare

change the "value" to @journey.fare

##journey attr_reader

change to @journey.history


=====

Station class

entry_station = Staion.new('amersham',9)
exit_station = Staion.new('oxford circus',1)

=====

Journey class

# initialized in Osytercard initialization

@journey = Journey.new
@journey.entry(entry_station)
@journey.exit(exit_station)

@journey.in_journey?
true = incomplete hash
false = complete hash

array = [{},{},{}]

hash = {
  entry station => entry_station.name
  entry zone => entry_station.zone
  exit station => exit_station.name
  exit zone => exit_station.name,
  complete? => false
}

#entry
journey << {
  :"entry station" => entry_station.name,
  :"entry zone" => entry_station.zone,
  :"exit station" => nil,
  :"exit zone" => nil
  :"in journey?" => true
}

#exit
journey.last.merge!(:"exit station" => exit_station.name, :"exit zone" => exit_station.zone, :"in journey?" => false)

#status
journey.last[:"in journey?"]

#journey_history
journey.last.slice(:"entry station", :"exit station") # WRONG NEED TO LOOP

#fare
1
