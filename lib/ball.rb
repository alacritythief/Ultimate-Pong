class Ball
  include BoundingBox
  attr_accessor :x, :y, :vx, :left, :right, :top, :bottom, :serve

  def initialize(window, x, y)
    @ball_image = Gosu::Image.new(window, "img/ball.png", false)
    @x = x
    @y = y
    @vx = @vy = 0
    @serve = false
    @ball_in_play = false
    bounding(@x, @y, 20, 20)
  end

  def draw
    @ball_image.draw(@x, @y, 1)
  end

  def in_play?
    @ball_in_play
  end

  def update
    if @serve == true
      if x < 400
        @vx = 5
      else
        @vx = -5
      end

      @vy = [5,-5].sample
      @ball_in_play = true
      @serve = false
    end

    @x += @vx
    @y += @vy

    if @y > 580
     @vy = -5
    end

    if @y < 0
      @vy = 5
    end

    bounding(@x, @y, 20, 20)
  end
end
