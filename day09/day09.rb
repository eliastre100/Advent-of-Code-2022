require_relative 'rope'

content = File.read(ARGV[0])

DIRECTIONS = {
  "R" => :right,
  "U" => :up,
  "L" => :left,
  "D" => :down
}

rope = Rope.new

content.split("\n")
       .map { |instruction| instruction.split }
       .each { |instruction| instruction.last.to_i.times { rope.move(DIRECTIONS[instruction.first]) } }

pp rope.tail_positions.size
