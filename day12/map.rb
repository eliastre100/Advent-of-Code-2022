class Map
  def initialize(width, height)
    @rows = Array.new(height) do
      Array.new(width) do
        {
          height: 0,
          score: Float::INFINITY
        }
      end
    end
    @start = { x: 0, y: 0 }
    @target = { x: 0, y: 0 }
  end

  def set_start(x, y)
    @start[:x] = x
    @start[:y] = y
    set_height(x, y, 0)
  end

  def set_target(x, y)
    @target[:x] = x
    @target[:y] = y
    set_height(x, y, "z".ord - "a".ord)
  end

  def set_height(x, y, height)
    @rows[y][x][:height] = height
  end

  def simulate
    resolve(@start[:x], @start[:y], 0)
  end

  def target
    @rows[@target[:y]][@target[:x]]
  end

  private

  def resolve(x, y, score)
    return if score_at(x, y) <= score

    set_score_at(x, y, score)
    electable_neighbours(x, y, height_at(x, y) + 1, score + 1).each do |position|
      resolve(position[:x], position[:y], score + 1)
    end
  end

  def score_at(x, y)
    return -Float::INFINITY if x < 0 || x >= @rows.first.size || y < 0 || y >= @rows.size
    @rows[y][x][:score]
  end

  def height_at(x, y)
    return -Float::INFINITY if x < 0 || x >= @rows.first.size || y < 0 || y >= @rows.size

    @rows[y][x][:height]
  end

  def set_score_at(x, y, score)
    @rows[y][x][:score] = score
  end

  def electable_neighbours(x, y, max_height, min_score)
    [[-1, 0], [1, 0], [0, -1], [0, 1]].map { |modifier|{ x: x + modifier[0], y: y + modifier[1] }}
                                      .select do |position|
      score = score_at(position[:x], position[:y])
      height = height_at(position[:x], position[:y])

      height <= max_height && score > min_score
    end
  end
end
