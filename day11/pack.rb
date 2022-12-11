class Pack
  attr_reader :monkeys

  def initialize
    @monkeys = []
  end

  def add_monkey(items, inspection_process, target_selection, targets)
    @monkeys.push({
                    items: items,
                    inspection_process: inspection_process,
                    target_selection: target_selection,
                    targets: targets,
                    activity: 0
                  })
  end

  def round
    @monkeys.each do |monkey|
      until monkey[:items].empty?
        throw_item(monkey, monkey[:items].shift)
        monkey[:activity] += 1
      end
    end
  end

  private

  def throw_item(monkey, item)
    item = monkey[:inspection_process].call(item)
    item = (item.to_f / 3).floor
    target = monkey[:targets][(item % monkey[:target_selection] == 0).to_s.to_sym]
    monkeys[target][:items].push(item)
  end
end
