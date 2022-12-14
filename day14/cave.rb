require 'matrix'

class Cave
  def initialize
    @map = {}
  end

  def add_rocks(positions)
    (0..(positions.size - 2)).map do |from|
      x_direction = positions[from + 1][0] - positions[from][0]
      y_direction = positions[from + 1][1] - positions[from][1]
      x_direction /= x_direction.abs unless x_direction.zero?
      y_direction /= y_direction.abs unless y_direction.zero?


      x = positions[from][0]
      y = positions[from][1]

      while x != positions[from + 1][0] || y != positions[from + 1][1]
        place_rock(x, y)
        x += x_direction
        y += y_direction
      end
      place_rock(x, y)
    end
  end

  def drop_sand(x, y)
    if y > lowest_rock
      false
    elsif free_space_at?(x, y + 1)
      drop_sand(x, y + 1)
    elsif free_space_at?(x - 1, y + 1)
      drop_sand(x - 1, y + 1)
    elsif free_space_at?(x + 1, y + 1)
      drop_sand(x + 1, y + 1)
    else
      place_sand(x, y)
      true
    end
  end

  private

  def place_at(x, y, value)
    @map[y] ||= {}
    @map[y][x] = value
  end

  def place_rock(x, y)
    place_at(x, y, :rock)
  end

  def place_sand(x, y)
    place_at(x, y, :sand)
  end

  def free_space_at?(x, y)
    (@map[y] || {})[x].nil?
  end

  def rock_at?(x, y)
    (@map[y] || {})[x] == :rock
  end

  def lowest_rock
    @map.keys.max
  end
end
