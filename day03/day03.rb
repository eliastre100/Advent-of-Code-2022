content = File.read(ARGV[0])

ITEMS_VALUES = ("a".."z").to_a + ("A".."Z").to_a

puts content.split("\n")
          .map { |backpack| [backpack[0..(backpack.size / 2 - 1)], backpack[(backpack.size / 2)..-1]] }
          .map { |a, b| a.chars & b.chars }
          .flatten
          .map { |item| ITEMS_VALUES.index(item) + 1 }
          .sum

