require_relative 'pair'

content = File.read(ARGV[0])

pairs = content.split("\n\n")
               .map.with_index do |pair, idx|
  Pair.new(idx + 1, *pair.split("\n"))
end

pp pairs.map { |pair| pair.sorted? ? pair.index : 0 }.sum
