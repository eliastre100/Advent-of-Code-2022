require 'set'

content = File.read(ARGV[0])

base = content.split("\n")
              .map { |group|
                group.split(",")
                     .map { |elf|
                       elf.split("-")
                          .map(&:to_i)
                          .inject { |a, b| Set.new(a..b) }
                     }
              }

puts base.select { |a, b| a.subset?(b) || b.subset?(a) }.count
puts base.reject { |a, b| a.intersection(b).empty? }.count
