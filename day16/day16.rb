require_relative 'valve'
require_relative 'itinerary'

content = File.read(ARGV[0])

instructions = content.split("\n")
                      .map do |string|
  {
    name: string.match(/Valve ([A-Z]+)/)[1],
    pressure: string.match(/([0-9]+)/)[1].to_i,
    valves: string.match(/valves? (.*)$/)[1].split(",").map(&:strip)
  }
end

valves = instructions.map do |instruction|
  [instruction[:name], Valve.new(instruction[:name], instruction[:pressure])]
end.to_h

instructions.each do |instruction|
  instruction[:valves].each do |valve|
    valves[instruction[:name]].connect(valves[valve])
  end
end

itinerary = Itinerary.new(valves.values)
pp itinerary.generate_itinerary(valves["AA"], 30)

#!1788
#1792
