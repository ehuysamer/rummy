class Position
  attr_reader :top, :right, :bottom, :left, :width, :height

  def initialize(top: nil, right: nil, bottom: nil, left: nil, width: nil, height: nil)
    @top = top
    @left = left
    @right = right
    @bottom = bottom
    @width = width
    @height = height
  end
end