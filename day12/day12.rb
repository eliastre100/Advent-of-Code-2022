require_relative 'map'

content = File.read(ARGV[0])
height = content.split("\n").size
width = content.split("\n").first.split("").size

map = Map.new(width, height)

content.split("\n").each_with_index do |row, y|
  row.split("").each_with_index do |cell, x|
    case cell
      when "S"
        map.set_start(x, y)
      when "E"
        map.set_target(x, y)
      else
        map.set_height(x, y, cell.ord - "a".ord)
    end
  end
end

map.simulate

pp map.target
