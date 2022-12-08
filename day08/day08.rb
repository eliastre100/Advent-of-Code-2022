map = File.read(ARGV[0]).split("\n").map { |row| row.split("").map(&:to_i) }
height_map = Array.new(map.size) { Array.new(map.first.size, 0) }

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

puts "map"
dump_map(map)

height_map = map.map.with_index do |row, y|
  row.map.with_index do |_, x|
    neighbours_value(x, y, map)
  end
end

puts "\nheight map"
dump_map(height_map)

pp(map.map.with_index do |row, y|
  row.select.with_index { |col, x| col > height_map[y][x] }
end.flatten.compact.size)
