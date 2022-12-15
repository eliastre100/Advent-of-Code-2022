class RangeOptimizer
  def initialize
    @ranges = []
  end

  def add(range)
    return self if existing_range?(range)
    return self if extend_existing_range(range)
    @ranges.push(range)
    self
  end

  def size_excluding(rejection_list)
    @ranges.map do |range|
      included_rejections = rejection_list.select { |value| range.include?(value) }.count
      range.size - included_rejections
    end.sum
  end

  def size
    @ranges.map(&:size).sum
  end

  def missing
    @ranges.each_cons(2)
  end

  private

  def extend_existing_range(range)
    candidate_index = @ranges.index do |elem|
      (range.first >= elem.first && range.first <= elem.last) ||
        (range.last >= elem.first && range.last <= elem.last) ||
        (elem.first >= range.first && elem.first <= range.last) ||
        (elem.last >= range.first && elem.last <= range.last)
    end
    if candidate_index
      candidate = @ranges[candidate_index]
      new_range = ([candidate.first, range.first].min)..([candidate.last, range.last].max)
      @ranges.delete_at(candidate_index)
      add(new_range)
      return true
    end
    false
  end

  def existing_range?(range)
    @ranges.any? { |elem| elem.first <= range.first && elem.last >= range.last }
  end
end
