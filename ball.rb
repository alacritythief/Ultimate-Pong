class Ball
  attr_accessor :x, :y, :vx, :left, :right, :top, :bottom

  def initialize(window)
    @ball_image = Gosu::Image.new(window, "ball.png", false)
    @x = @y = rand(300..500)
    @vx = @vy = 5
    bounding(@x, @y, 20, 20)
  end

  def draw
    @ball_image.draw(@x, @y, 1)
  end

  def update
    @x += @vx
    @y += @vy

    # if @x > 780
    #   @vx = -5
    # end

    if @y > 580
      @vy = -5
    end

    # if @x < 0
    #   @vx = 5
    # end

    if @y < 0
      @vy = 5
    end

    bounding(@x, @y, 20, 20)
  end

  def bounding(left, bottom, width, height)
    @left = left
    @bottom = bottom
    @width = width
    @height = height

    @right = @left + @width
    @top = @bottom + @height
  end

end
