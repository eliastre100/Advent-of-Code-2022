require_relative 'filesystem'
require_relative 'terminal'

content = File.read(ARGV[0])

filesystem = FileSystem.new(70000000)
terminal = Terminal.new(filesystem)

content.split("$ ")
       .reject(&:empty?)
       .map { |raw_cmd| raw_cmd.split("\n") }
       .each { |cmd_group| terminal.interpret(cmd_group[0], cmd_group[1..-1]) }

filesystem.dump
puts filesystem.select_folders { |folder| folder.size <= 100000 }
               .map(&:size)
               .sum

required_space = 30000000 - filesystem.freespace
puts filesystem.select_folders { |folder| folder.size >= required_space }
             .sort { |a, b| a.size <=> b.size }
             .first.size
