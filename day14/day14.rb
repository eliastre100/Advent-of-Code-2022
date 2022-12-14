require_relative 'cave'

content = File.read(ARGV[0])

cave = Cave.new

content.split("\n").each do |line|
  cave.add_rocks(line.split("->")
      .map(&:strip)
      .map do |coordinate|
    coordinate.split(",").map(&:to_i)
  end)
end

sand_droped = 0
while cave.drop_sand(500, 0)
  sand_droped += 1
end
pp sand_droped
