require_relative '../helpers/array'

class List
  attr_reader :values

  def self.wrap(value)
    return value if value.is_a?(List)

    List.new(Array.wrap(value))
  end

  def initialize(values)
    @values = values.map do |value|
      if value.is_a?(Array)
        List.new(value)
      else
        value
      end
    end
  end

  def sorted?(other, idx = 0)
    puts "- Compare #{@values} vs #{other.values}" if idx == 0
    return nil if @values[idx].nil? && other.values[idx].nil?
    return true if @values[idx].nil?
    return false if other.values[idx].nil?

    local_value = @values[idx]
    other_value = other.values[idx]

    puts "compare #{local_value} vs #{other_value}"

    if local_value.is_a?(Integer) && other_value.is_a?(Integer)
      return false if local_value > other_value
      return true if local_value < other_value
    else
      sorted = List.wrap(local_value).sorted?(List.wrap(other_value))
      return sorted unless sorted.nil?
    end
    sorted?(other, idx + 1)
  end
end
