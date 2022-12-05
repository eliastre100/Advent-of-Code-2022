class Deck
  attr_accessor :stacks

  def initialize(size)
    @stacks = Array.new(size) { [] }
  end

  def add_crate(crate, stack)
    @stacks[stack].push(crate)
  end

  def move(qty, from, to)
    @stacks[to - 1].push(*@stacks[from - 1].pop(qty))
  end

  def top_rows
    @stacks.map(&:last).join
  end
end
