class Itinerary
  def initialize(valves)
    @valves = valves
    @interest = valves.select { |valve| valve.pressure > 0 }
  end

  def generate_itinerary(from, timer, score = 0, opened = [])
    #puts "====="
    #puts "On #{from} with #{timer} minutes left"
    #puts "Current max score = #{score}"
    #puts "Valves opened: #{opened.map(&:name).join(", ")}"
    available_destinations = (@interest - opened).reject do |target|
      from.distance_to(target) > timer - 1
    end
    return score if available_destinations.empty?
    #puts "Considering #{available_destinations.map(&:name).join(", ")}"
    available_destinations.map do |target|
      remaining_time_after_open = timer - from.distance_to(target) - 1
      route_score = score + target.pressure * remaining_time_after_open
      generate_itinerary(target, remaining_time_after_open, route_score, opened + [target])
    end.max
    #puts "Heading to #{chosen_destination.max { |target| target[1] }}"
  end

  private

  def generate_routing
    valve_of_interest = @valves.select { |valve| valve.pressure > 0 }
    pp valve_of_interest
    @valves.map.with_index do |valve, idx|
      distances = valve_of_interest.map do |target|
        valve.add_known_path(target, valve.distance_to(target))
        [target, valve.distance_to(target)]
      end.to_h
      puts "#{idx}/#{@valves.size}"
      [valve, distances]
    end.to_h
  end
end
