require_relative 'sensor'

content = File.read(ARGV[0])

sensors = content.split("\n")
                 .map do |instruction|
  positions = instruction.scan(/(-?[0-9]+)/).flatten.map(&:to_i)
  Sensor.new(positions[0], positions[1]).add_beacon(positions[2], positions[3])
end

SEARCH_Y = 2000000

beacons_positions = sensors.map(&:beacons).flatten.reject { |beacon| beacon[:y] != SEARCH_Y }.map { |position| position[:x] }.uniq
pp sensors.map { |sensor| sensor.positions_covered_at(SEARCH_Y) }
          .flatten.uniq
          .reject { |position| beacons_positions.include?(position) }
          .count
