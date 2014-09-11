require 'rubygems'
require 'gosu'

require_relative 'keys'
require_relative 'bounding_box'
require_relative 'ball'
require_relative 'paddle'

require 'pry'

class GameWindow < Gosu::Window
  include Keys

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

    if @bouncing_ball.x < 0 || @bouncing_ball.x > 800
      @bouncing_ball = Ball.new(self)
    end
  end

  def draw
    @bouncing_ball.draw
    @paddle_left.draw
    @paddle_right.draw
  end
end

window = GameWindow.new
window.show
