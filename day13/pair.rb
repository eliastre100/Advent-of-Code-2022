require_relative 'list'

class Pair
  attr_reader :index
  def initialize(index, left, right)
    @index = index
    @left =  List.new(eval(left))
    @right = List.new(eval(right))
  end

  def sorted?
    @left.sorted?(@right)
  end
end
