require_relative 'map'

class ReverseMap < Map
  def simulate
    starting_points = @rows.map.with_index do |row, y|
      row.map.with_index do |cell, x|
        if cell[:height] == 0
          { x: x, y: y}
        else
          nil
        end
      end
    end.flatten.compact.each do |position|
      set_start(position[:x], position[:y])
      super
    end
  end
end
