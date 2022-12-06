content = File.read(ARGV[0]).chars

SEARCH_SIZE = 14

puts(content.map.with_index do |_, index|
  { tokens: content[index..(index + SEARCH_SIZE - 1)], index: index }
end.detect { |group| group[:tokens].uniq.size == SEARCH_SIZE }[:index] + SEARCH_SIZE)
