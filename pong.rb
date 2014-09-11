require 'rubygems'
require 'gosu'
require 'pry'

class Paddle
  attr_accessor :velocity, :x, :y

  def initialize(window, x, y)
    @paddle_image = Gosu::Image.new(window, "paddle.png", false)
    @x = x
    @y = y
    @velocity = 0
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

  end
end

class Ball
  attr_accessor :x, :y, :vx

  def initialize(window)
    @ball_image = Gosu::Image.new(window, "ball.png", false)
    @x = @y = 100
    @vx = @vy = 5
  end

  def draw
    @ball_image.draw(@x, @y, 1)
  end

  def update
    @x += @vx
    @y += @vy

    if @x > 780
      @vx = -5
    end

    if @y > 580
      @vy = -5
    end

    # if @x < 0
    #   @vx = 5
    # end

    if @y < 0
      @vy = 5
    end

  end

end

class GameWindow < Gosu::Window
  def initialize
    super 800, 600, false
    self.caption = "Paddle Game"
    @bouncing_ball = Ball.new(self)
    @paddle_left = Paddle.new(self, 10, 250)
    @paddle_right = Paddle.new(self, 770, 250)
  end

  def update
    @bouncing_ball.update
    @paddle_left.update
    @paddle_right.update


    if @bouncing_ball.x > 29 && @bouncing_ball.x < 41 and @bouncing_ball.y > @paddle_left.y - 10 && @bouncing_ball.y < @paddle_left.y + 110
      @bouncing_ball.vx = +5
    end


  end

  def draw
    @bouncing_ball.draw
    @paddle_left.draw
    @paddle_right.draw
  end

  def button_down(id)
    if id == Gosu::KbW
      @paddle_left.velocity += -8
    end

    if id == Gosu::KbS
      @paddle_left.velocity += 8
    end
  end

  def button_up(id)
    if id == Gosu::KbW
      @paddle_left.velocity += 8
    end

    if id == Gosu::KbS
      @paddle_left.velocity += -8
    end
  end

end

window = GameWindow.new
window.show
