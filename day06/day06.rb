content = File.read(ARGV[0]).chars

require "awesome_print"

ap(content.map.with_index do |_, index|
  { tokens: content[index..(index + 3)], index: index }
end.detect { |group| group[:tokens].uniq.size == 4 }[:index] + 4)
