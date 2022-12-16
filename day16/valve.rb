class Valve
  attr_reader :name, :max_release, :pressure, :neighbours, :known_paths

  def initialize(name, pressure)
    @name = name
    @pressure = pressure
    @neighbours = []
    @known_paths = { self => 0 }
  end

  def connect(valve)
    @neighbours.push(valve)
    @known_paths[valve] = 1
    discover(valve, force: true)
  end

  def distance_to(target, distance = 0, visited = [])
    return Float::INFINITY if visited.include?(self)
    return distance if target == self
    return @known_paths[target] if @known_paths[target]

    puts "[WARNING] Unknown route. This should not be happening!"

    @neighbours.map { |neighbor| neighbor.distance_to(target, distance + 1, visited + [self]) }.min
  end

  def discover(valve, force: false)
    changed = false
    valve.known_paths.each do |target, cost|
      if @known_paths[target].nil? || @known_paths[target] > cost + 1
        @known_paths[target] = cost + 1
        changed = true
      end
    end
    if changed || force
      @neighbours.each { |neighbor| neighbor.discover(self) }
    end
  end

  def to_s
    "#{name} (#{pressure})"
  end

  def inspect
    to_s
  end
end
