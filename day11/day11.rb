require_relative 'pack'

content = File.read(ARGV[0])

pack = Pack.new

content.split("\n\n")
       .map { |monkey_definition| monkey_definition.split("\n") }
       .each do |monkey_definition|
  items = monkey_definition[1].scan(/[0-9]+/).map(&:to_i)

  inspection_definition = monkey_definition[2].split("=").last.strip
  inspection_process = ->(old) { eval(inspection_definition.gsub(/old/, old.to_s)) }

  target_selection = monkey_definition[3].scan(/[0-9]+/).first.to_i

  targets = {
    true: monkey_definition[4].scan(/[0-9]+/).first.to_i,
    false: monkey_definition[5].scan(/[0-9]+/).first.to_i,

  }

  pack.add_monkey(items, inspection_process, target_selection, targets)
end

20.times { pack.round }

pp pack.monkeys.map { |monkey| monkey[:activity] }.max(2).inject(&:*)
