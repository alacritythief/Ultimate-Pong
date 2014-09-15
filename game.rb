require 'rubygems'
require 'gosu'
require 'ashton'

require_relative 'lib/keys'
require_relative 'lib/bounding_box'
require_relative 'lib/ball'
require_relative 'lib/paddle'
require_relative 'lib/scoreboard'

class GameWindow < Gosu::Window
  include Keys

  def initialize
    super 800, 600, false
    self.caption = "Ultimate Pong"

    @bouncing_ball = Ball.new(self, 40, 290)

    @paddle_left = Paddle.new(self, 10, 250)
    @paddle_right = Paddle.new(self, 770, 250)

    @score = Scoreboard.new(self)

    @toggle_ai = false
    @ai_status = "OFF"

    @ai_on = Gosu::Font.new(self, "helvetica", 20)
    @ready_to_serve = Gosu::Font.new(self, "helvetica", 20)
  end

  def update
    @bouncing_ball.update
    @paddle_left.update
    @paddle_right.update

    computer_ai

    if @paddle_left.collide?(@bouncing_ball.left, @bouncing_ball.top) == true
      @bouncing_ball.vx = +5
    end

    if @paddle_right.collide?(@bouncing_ball.right, @bouncing_ball.bottom) == true
      @bouncing_ball.vx = -5
    end

    scoring
  end

  def scoring
    if @bouncing_ball.x < -30
      @bouncing_ball = Ball.new(self, 730, 290)
      @score.player_right += 1
      reset_paddle_positions
    end

    if @bouncing_ball.right > 830
      @bouncing_ball = Ball.new(self, 40, 290)
      @score.player_left += 1
      reset_paddle_positions
    end
  end

  def reset_paddle_positions
    @paddle_left.x = 10
    @paddle_left.y = 250
    @paddle_right.x = 770
    @paddle_right.y = 250
  end

  def draw
    @bouncing_ball.draw
    @paddle_left.draw
    @paddle_right.draw
    @score.draw
    @ai_on.draw("AI #{@ai_status}", 370, 30, 0, 1.0, 1.0, 0xffffffff)

    if @bouncing_ball.in_play? == false
      @ready_to_serve.draw("Press SPACE to serve!", 310, 300, 0, 1.0, 1.0, 0xffffffff)
    end
  end

  def computer_ai
    if @toggle_ai == true
      @ai_status = "ON"

      @paddle_right.velocity = @bouncing_ball.vy

    else
      @ai_status = "OFF"
    end
  end
end

window = GameWindow.new
window.show
