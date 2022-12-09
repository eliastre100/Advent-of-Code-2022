class Rope
  attr_reader :tail_positions, :head, :tail

  def initialize
    @head = { x: 0, y: 0 }
    @tail = { x: 0, y: 0 }
    @tail_positions = ["0-0"]
  end

  def move(direction)
    method(direction.to_sym).call
    resolve_tail
  end

  private

  def right
    @head[:x] += 1
  end

  def left
    @head[:x] -= 1
  end

  def up
    @head[:y] -= 1
  end

  def down
    @head[:y] += 1
  end

  def in_x_range?(x)
    ((@head[:x] - 1)..(@head[:x] + 1)).include?(x)
  end

  def in_y_range?(y)
    ((@head[:y] - 1)..(head[:y] + 1)).include?(y)
  end

  def safe_divider(x)
    return 1 if x == 0
    x.abs
  end

  def normal_vector_from(vector)
    #length = Integer.sqrt(vector[:x].pow(2) + vector[:y].pow(2))
    #{ x: vector[:x].to_f / length, y: vector[:y].to_f / length }
    { x: vector[:x] / safe_divider(vector[:x]), y: vector[:y] / safe_divider(vector[:y]) }
  end

  def resolve_tail
    return if  in_x_range?(@tail[:x]) && in_y_range?(@tail[:y])
    traction_vector = normal_vector_from({ x: @head[:x] - @tail[:x], y: @head[:y] - @tail[:y] })
    @tail[:x] += traction_vector[:x]
    @tail[:y] += traction_vector[:y]
    @tail_positions.push("#{tail[:x]}-#{tail[:y]}").uniq!
  end
end
