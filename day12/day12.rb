require_relative 'map'
require_relative 'reverse_map'

content = File.read(ARGV[0])
height = content.split("\n").size
width = content.split("\n").first.split("").size

map = Map.new(width, height)
reverse_map = ReverseMap.new(width, height)

content.split("\n").each_with_index do |row, y|
  row.split("").each_with_index do |cell, x|
    case cell
      when "S"
        map.set_start(x, y)
        reverse_map.set_height(x, y, 0)
      when "E"
        map.set_target(x, y)
        reverse_map.set_target(x, y)
      else
        map.set_height(x, y, cell.ord - "a".ord)
        reverse_map.set_height(x, y, cell.ord - "a".ord)
    end
  end
end

map.simulate
reverse_map.simulate

pp map.target
pp reverse_map.target
