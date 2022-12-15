require_relative 'sensor'
require_relative 'range_optimizer'

content = File.read(ARGV[0])

sensors = content.split("\n")
                 .map do |instruction|
  positions = instruction.scan(/(-?[0-9]+)/).flatten.map(&:to_i)
  Sensor.new(positions[0], positions[1]).add_beacon(positions[2], positions[3])
end

SEARCH_Y = 2000000

beacons_positions = sensors.map(&:beacons).flatten.reject { |beacon| beacon[:y] != SEARCH_Y }.map { |position| position[:x] }.uniq
pp sensors.map { |sensor| sensor.positions_covered_at(SEARCH_Y) }
          .inject(RangeOptimizer.new) { |optimizer, positions| optimizer.add(positions) }
          .size_excluding(beacons_positions)

MIN_POSITION = 0
MAX_POSITION = 4000000
MAX_SIZE = (MIN_POSITION..MAX_POSITION).size

y = (MIN_POSITION..MAX_POSITION).find do |pos|
  sensors.map { |sensor| sensor.positions_covered_at(pos, min: 0, max: MAX_POSITION) }
         .inject(RangeOptimizer.new) { |optimizer, positions| optimizer.add(positions) }
    .size != MAX_SIZE
end

x = sensors.map { |sensor| sensor.positions_covered_at(y, min: 0, max: MAX_POSITION) }
               .inject(RangeOptimizer.new) { |optimizer, positions| optimizer.add(positions) }
  .missing
  .map { |group| ((group[0].last + 1)..(group[1].first - 1)).to_a }
  .flatten.first

frequency = x * 4000000 + y

puts "Beacon at #{x};#{y} => #{frequency}"
