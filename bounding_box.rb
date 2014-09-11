class BoundingBox
  attr_reader :left, :bottom, :width, :height, :right, :top

  def initialize(left, bottom, width, height)
    @left = left
    @bottom = bottom
    @width = width
    @height = height

    @right = @left + @width
    @top = @bottom + @height
  end

  def contains_point?(x,y)
    if x >= @left && x <= @right && y >= @bottom && y <= @top
      true
    else
      false
    end
  end
end
