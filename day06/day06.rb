content = File.read(ARGV[0]).chars

SEARCH_SIZE = 14

puts((0..(content.size)).detect do |index|
  content[index..(index + SEARCH_SIZE - 1)].uniq.size == SEARCH_SIZE
end + SEARCH_SIZE)
