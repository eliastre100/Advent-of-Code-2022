class Itinerary
  def initialize(valves)
    @valves = valves
    @interest = valves.select { |valve| valve.pressure > 0 }
  end

  def generate_itinerary(from, timer, score = 0, opened = [])
    available_destinations = (@interest - opened).reject do |target|
      from.distance_to(target) > timer - 1
    end
    return score if available_destinations.empty?
    available_destinations.map do |target|
      remaining_time_after_open = timer - from.distance_to(target) - 1
      route_score = score + target.pressure * remaining_time_after_open
      generate_itinerary(target, remaining_time_after_open, route_score, opened + [target])
    end.max
  end
end
