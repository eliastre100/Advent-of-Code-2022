content = File.read(ARGV[0])
require 'set'

puts content.split("\n")
            .map { |group|
              group.split(",")
                   .map { |elf|
                     elf.split("-")
                        .map(&:to_i)
                        .inject { |a, b| Set.new(a..b) }
                   }
            }
            .select { |a, b| a.subset?(b) || b.subset?(a) }
            .count
