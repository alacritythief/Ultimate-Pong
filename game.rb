# Ultimate Pong v1 - by Andy Wong

require 'rubygems'
require 'gosu'
require 'ashton'

require_relative 'lib/keys'
require_relative 'lib/bounding_box'
require_relative 'lib/ball'
require_relative 'lib/ee_ball'
require_relative 'lib/paddle'
require_relative 'lib/scoreboard'

class GameWindow < Gosu::Window
  include Keys

  def initialize
    super 800, 600, false
    self.caption = "Ultimate Pong"

    @toggle_ai = false
    @toggle_demo = false
    @toggle_ee = false

    summon_ball_type(self, 40, 290)

    @paddle_left = Paddle.new(self, 10, 250)
    @paddle_right = Paddle.new(self, 770, 250)

    @score = Scoreboard.new(self)
    @ai_status = "AI OFF"

    @ai_on = Gosu::Font.new(self, "helvetica", 20)
    @ready_to_serve = Gosu::Font.new(self, "helvetica", 20)
  end

  def update
    @bouncing_ball.update
    @paddle_left.update
    @paddle_right.update

    computer_ai
    ball_collision
    scoring
  end

  def scoring
    if @bouncing_ball.x < -30
      if @toggle_ee == true
        summon_ball_type(self, 660, 290)
      else
        summon_ball_type(self, 730, 290)
      end
      @score.player_right += 1
      reset_paddle_positions
    end

    if @bouncing_ball.right > 830
      summon_ball_type(self, 40, 290)
      @score.player_left += 1
      reset_paddle_positions
    end
  end

  def draw
    @bouncing_ball.draw
    @paddle_left.draw
    @paddle_right.draw
    @score.draw
    if @toggle_ai == true
      @ai_on.draw("#{@ai_status}", 370, 30, 0, 1.0, 1.0, 0xffffffff)
    elsif @toggle_ai == false && @toggle_demo == true
      @ai_on.draw("#{@ai_status}", 345, 30, 0, 1.0, 1.0, 0xffffffff)
    end

    if @bouncing_ball.in_play? == false
      @ready_to_serve.draw("Press SPACE to serve!", 310, 300, 0, 1.0, 1.0, 0xffffffff)
    end
  end

  def summon_ball_type(window, x, y)
    if @toggle_ee == true
      @bouncing_ball = EeBall.new(window, x, 250)
    elsif @toggle_ee == false
      @bouncing_ball = Ball.new(window, x, y)
    end
  end

  def reset_paddle_positions
    @paddle_right.x = 770
    @paddle_right.y = 250
    @paddle_left.x = 10
    @paddle_left.y = 250
  end

  def ball_collision
    if @paddle_left.collide?(@bouncing_ball.left, @bouncing_ball.bottom) == true || @paddle_left.collide?(@bouncing_ball.left, @bouncing_ball.top) == true
      if @bouncing_ball.speed < 20
        @bouncing_ball.speed += 0.5
      end
      @bouncing_ball.vx = +5 + @bouncing_ball.speed
      @bouncing_ball.quotes
    end

    if @paddle_right.collide?(@bouncing_ball.right, @bouncing_ball.bottom) == true || @paddle_right.collide?(@bouncing_ball.right, @bouncing_ball.top) == true
      if @bouncing_ball.speed < 20
        @bouncing_ball.speed += 0.5
      end
      @bouncing_ball.vx = -5 + -(@bouncing_ball.speed)
      @bouncing_ball.quotes
    end
  end

  def computer_ai
    if @toggle_ai == true
      @ai_status = "AI ON"
      @paddle_right.velocity = @bouncing_ball.vy * [0.85,0.85,0.6,0.85,0.6].sample
    elsif @toggle_demo == true
      @ai_status = "DEMO MODE"
      @paddle_right.y = @bouncing_ball.y - 50 + @bouncing_ball.height / 2
      @paddle_left.y = @bouncing_ball.y - 50 + @bouncing_ball.height / 2
    else
      @ai_status = "AI OFF"
    end
  end
end

window = GameWindow.new
window.show
