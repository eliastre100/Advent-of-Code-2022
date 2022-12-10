require_relative 'cpu'

content = File.read(ARGV[0])

strengths = []

cpu = Cpu.new(40) do |cycle, x|
  puts "get cycle ! #{cycle} #{x} #{cycle * x}"
  strengths.push(cycle * x)
end

content.split("\n")
       .map { |row| row.split(" ") }
       .each { |instructions| cpu.call(instructions[0], instructions[1]) }

pp strengths.sum
