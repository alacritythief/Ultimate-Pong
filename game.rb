require 'rubygems'
require 'gosu'

require_relative 'ball'
require_relative 'paddle'

require 'pry'

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

    if @paddle_left.collide?(@bouncing_ball.x, @bouncing_ball.y) == true
      @bouncing_ball.vx = +5
    end

    if @paddle_right.collide?(@bouncing_ball.right, @bouncing_ball.bottom) == true
      @bouncing_ball.vx = -5
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

    if id == Gosu::KbI
      @paddle_right.velocity += -8
    end

    if id == Gosu::KbK
      @paddle_right.velocity += 8
    end

  end

  def button_up(id)
    if id == Gosu::KbW
      @paddle_left.velocity += 8
    end

    if id == Gosu::KbS
      @paddle_left.velocity += -8
    end

    if id == Gosu::KbI
      @paddle_right.velocity += 8
    end

    if id == Gosu::KbK
      @paddle_right.velocity += -8
    end

  end

end

window = GameWindow.new
window.show
