require_relative 'itinerary'

class DoubleItinerary < Itinerary
  def generate_itinerary(from, timer)
    pawn1 = { vanne: from, cooldown: 0, finish: false }
    pawn2 = { vanne: from, cooldown: 0, finish: false }
    step([pawn1, pawn2], timer)
  end

  private

  def step(pawns, timer, score = 0, opened = [])
    pawns = pawns.map(&:dup)
    return score if timer <= 0
    return score if pawns.reject { |pawn| pawn[:finish] }.empty?
    pawn_idx = pawns.index { |pawn| !pawn[:finish] && pawn[:cooldown] <= 0 }
    if pawn_idx
      handle_next_objective(pawns, pawn_idx, timer, score, opened)
    else
      next_action = pawns.map { |pawn| pawn[:finish] ? Float::INFINITY : pawn[:cooldown] }.min
      pawns.each { |pawn| pawn[:cooldown] -= next_action }
      step(pawns, timer - next_action, score, opened)
    end
  end

  def remaining_interests(from, opened, timer)
    (@interest - opened).reject do |target|
      from.distance_to(target) > timer - 1
    end
  end

  def handle_next_objective(pawns, pawn_id, timer, score, opened)
    available_destinations = remaining_interests(pawns[pawn_id][:vanne], opened, timer)
    if available_destinations.empty?
      pawns[pawn_id][:finish] = true
      return step(pawns, timer, score, opened)
    end

    original_pawns = pawns
    available_destinations.map do |target|
      pawns = original_pawns.map(&:dup)
      remaining_time_after_open = timer - pawns[pawn_id][:vanne].distance_to(target) - 1
      route_score = score + target.pressure * remaining_time_after_open
      pawns[pawn_id][:cooldown] = pawns[pawn_id][:vanne].distance_to(target) + 1
      pawns[pawn_id][:vanne] = target
      step(pawns, timer, route_score, opened + [target])
    end.max
  end
end
