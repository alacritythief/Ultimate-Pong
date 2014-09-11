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
    @bouncing_ball = Ball.new(self)
    @paddle_left = Paddle.new(self, 10, 250)
    @paddle_right = Paddle.new(self, 770, 250)
    @score = Scoreboard.new(self)
    @fireball = Ashton::ParticleEmitter.new 0, 0, 3,
                                           scale: 8,
                                           speed: 1..100,
                                           max_particles: 1000,
                                           offset: 0..10,
                                           interval: 0.0010,
                                           color: Gosu::Color.rgba(255, 150, 0, 50),
                                           fade: 70,
                                           gravity: 0
  end

  def update
    @bouncing_ball.update
    @paddle_left.update
    @paddle_right.update

    @last_update_at ||= Gosu::milliseconds
    particle_timer = [Gosu::milliseconds - @last_update_at, 100].min * 0.001
    @last_update_at = Gosu::milliseconds

    @fireball.update particle_timer
    @fireball.x, @fireball.y = @bouncing_ball.x + 10, @bouncing_ball.y + 10

    if @paddle_left.collide?(@bouncing_ball.left, @bouncing_ball.top) == true
      @bouncing_ball.vx = +5
    end

    if @paddle_right.collide?(@bouncing_ball.right, @bouncing_ball.bottom) == true
      @bouncing_ball.vx = -5
    end

    if @bouncing_ball.x < -30
      @bouncing_ball = Ball.new(self)
      @score.player_right += 1
    end

    if @bouncing_ball.right > 830
      @bouncing_ball = Ball.new(self)
      @score.player_left += 1
    end

  end

  def draw
    @bouncing_ball.draw
    @paddle_left.draw
    @paddle_right.draw
    @score.draw
    @fireball.draw
  end
end

window = GameWindow.new
window.show
