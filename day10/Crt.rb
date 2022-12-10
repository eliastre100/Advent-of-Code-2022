class Crt
  def initialize
    @screen = Array.new(6) { Array.new(40) { "0" }}
  end

  def draw(cycles, x)
    cycles.each do |cycle|
      draw_pixel(cycle - 1, x)
    end
  end

  def draw_pixel(cycle, x)
    row = cycle / 40
    cell = cycle % 40
    sprite = (x - 1)..(x + 1)
    return if row >= 6 || cell >= 40

    @screen[row][cell] = sprite.include?(cell) ? "#" : "."
  end

  def print
    puts @screen.map {  |row| row.join }.join("\n")
  end
end
