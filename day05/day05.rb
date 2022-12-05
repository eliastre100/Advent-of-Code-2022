require_relative 'deck'
require "awesome_print"

content = File.read(ARGV[0]).split("\n\n")

# Parsing
deck_map = content.first
                  .split("\n")
                  .map do |row|
  row.chars
     .each_slice(4).to_a
     .map(&:join)
     .map { |stack| stack.scan(/\w/) }
end

instructions = content[1].split("\n")
                         .map do |instruction|
  instruction.scan(/[0-9]+/)
             .map(&:to_i)
end

# Structuring
deck = Deck.new(deck_map.pop.size)

deck_map.reverse_each.with_index do |stack|
  stack.each_with_index do |crate, stack_id|
    next unless crate.first
    deck.add_crate(crate.first, stack_id)
  end
end

# Processing

instructions.each do |instruction|
  deck.move(*instruction)
end

puts deck.top_rows
