require_relative '../helpers/helpers'

content = File.read(ARGV[0])

puts content.split("\n")
            .split { |line| line.empty? }
            .map { |inventory| inventory.map(&:to_i) }
            .map(&:sum)
            .max(3)
            .sum
