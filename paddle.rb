class Paddle
  attr_accessor :velocity, :x, :y

  def initialize(window, x, y)
    @paddle_image = Gosu::Image.new(window, "paddle.png", false)
    @x = x
    @y = y
    @velocity = 0
    bounding(@x, @y, 20, 100)
  end

  def draw
    @paddle_image.draw(@x, @y, 1)
  end

  def update

    if @y < 0 && @velocity < 0
    elsif @y > 500 && @velocity > 0
    else
      @y += @velocity
    end

    bounding(@x, @y, 20, 100)

  end

  def bounding(left, bottom, width, height)
    @left = left
    @bottom = bottom
    @width = width
    @height = height

    @right = @left + @width
    @top = @bottom + @height
  end

  def collide?(x,y)
    if x >= @left && x <= @right && y >= @bottom && y <= @top
      true
    else
      false
    end
  end

  def ai
    #to be made
  end

end
