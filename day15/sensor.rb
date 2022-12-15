class Sensor
  attr_reader :beacons

  def initialize(x, y)
    @position = { x: x, y: y }
    @beacons = []
  end

  def add_beacon(x, y)
    @beacons.push({ x: x, y: y })
    self
  end

  def positions_covered_at(y, min: -Float::INFINITY, max: Float::INFINITY)
    distance = manhattan(@position, @beacons.first) - (@position[:y] - y).abs
    #return (0..0) if distance < 0
    c1 = @position[:x] - distance
    c2 = @position[:x] + distance
    c1 = min if c1 < min
    c2 = max if c2 > max
    c1..c2
  end

  def reject_beacon_positions(positions)
    positions.reject { |position| @beacons.include?(position) }
  end

  private

  def manhattan(a, b)
    (a[:x] - b[:x]).abs + (a[:y] - b[:y]).abs
  end
end
