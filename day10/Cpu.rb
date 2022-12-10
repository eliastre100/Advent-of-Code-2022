require_relative 'crt'

class Cpu
  attr_reader :x, :crt

  def initialize(steps, &strengths_callback)
    @x = 1
    @cycle = 1
    @target_cycle = 20
    @steps = steps
    @strengths_callback = strengths_callback
    @crt = Crt.new
  end

  def call(instruction, arguments)
    previous_x = @x
    previous_cycle = @cycle
    method(instruction.to_sym).call(arguments.to_i)
    call_cycles = previous_cycle..@cycle

    @crt.draw((previous_cycle..(@cycle - 1)), previous_x)
    if @cycle == @target_cycle
      trigger_callback(@x)
    elsif call_cycles.include?(@target_cycle)
      trigger_callback(previous_x)
    end
  end

  def noop(_)
    @cycle += 1
  end

  def addx(x)
    @cycle += 2
    @x += x
  end

  def trigger_callback(x)
    @strengths_callback.call(@target_cycle, x) if @strengths_callback
    @target_cycle += @steps
  end
end
