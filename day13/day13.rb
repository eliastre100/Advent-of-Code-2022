require_relative 'pair'

content = File.read(ARGV[0])

pairs = content.split("\n\n")
               .map.with_index do |pair, idx|
  Pair.new(idx + 1, *pair.split("\n"))
end

pp pairs.map { |pair| pair.sorted? ? pair.index : 0 }.sum

dividers = [List.new([[2]]), List.new([[6]])]
lists = content.split("\n\n")
               .map { |pair| pair.split("\n") }
               .flatten
               .map { |definition| List.new(eval(definition)) } + dividers

lists.sort! { |a, b| a.sorted?(b) ? -1 : 1 }

pp lists.map.with_index { |list, idx| dividers.include?(list) ? idx + 1: 0 }.reject(&:zero?).inject(&:*)
