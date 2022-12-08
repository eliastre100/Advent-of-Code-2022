map = File.read(ARGV[0]).split("\n").map { |row| row.split("").map(&:to_i) }

def dump_map(map)
  map.each do |row|
    row.each do |cell|
      print cell
    end
    print "\n"
  end
end

def position_value(x, y, map)
  if x < 0 || x >= map.first.size || y < 0 || y >= map.size
    return -1
  end
  map[y][x]
end

def neighbours_value(x, y, map)
  left = (0..(x - 1)).map { |x| position_value(x, y, map) }.max || -1
  right = ((x + 1)..map.first.size).map { |x| position_value(x, y, map) }.max || -1
  top = (0..(y - 1)).map { |y| position_value(x, y, map) }.max || -1
  down = ((y + 1)..map.size).map { |y| position_value(x, y, map) }.max || -1

  [left, right, top, down].min
end

def view_distance(x, y, map, height, view_vector, score = 0)
  next_pos = { x: x + view_vector[:x], y: y + view_vector[:y] }
  next_pos_value = position_value(next_pos[:x], next_pos[:y], map)
  return score if next_pos_value == -1
  score += 1
  return score if height <= next_pos_value
  view_distance(next_pos[:x], next_pos[:y], map, height, view_vector, score)
end

def scenic_score(x, y, map)
  height = position_value(x, y, map)
  left = view_distance(x, y, map, height, { x: -1, y: 0 })
  right = view_distance(x, y, map, height, { x: 1, y: 0 })
  top = view_distance(x, y, map, height, { x: 0, y: -1 })
  down = view_distance(x, y, map, height, { x: 0, y: 1 })

  left * right * top * down
end

height_map = map.map.with_index do |row, y|
  row.map.with_index do |_, x|
    neighbours_value(x, y, map)
  end
end

pp(map.map.with_index do |row, y|
  row.select.with_index { |col, x| col > height_map[y][x] }
end.flatten.compact.size)

pp((0..(map.size - 1)).map do |y|
  (0..(map.first.size - 1)).map do |x|
    scenic_score(x, y, map)
  end
end.flatten.max)
