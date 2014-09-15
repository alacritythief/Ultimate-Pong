class Ball
  include BoundingBox
  attr_accessor :x, :y, :vx, :vy, :left, :right, :top, :bottom, :serve, :speed

  def initialize(window, x, y)
    @ball_image = Gosu::Image.new(window, "img/ball.png", false)
    @x = x
    @y = y
    @vx = @vy = 0
    @serve = false
    @ball_in_play = false
    @speed = 0

    @particle = Ashton::ParticleEmitter.new 0, 0, 3,
                                           scale: 8,
                                           speed: 1..100,
                                           max_particles: 1000,
                                           offset: 0..10,
                                           interval: 0.0010,
                                           color: Gosu::Color.rgba(255, 150, 0, 50),
                                           fade: 70,
                                           gravity: 0

    bounding(@x, @y, 20, 20)
  end

  def draw
    @ball_image.draw(@x, @y, 1)
    @particle.draw
  end

  def in_play?
    @ball_in_play
  end

  def particle_calc
    @last_update_at ||= Gosu::milliseconds
    particle_timer = [Gosu::milliseconds - @last_update_at, 100].min * 0.001
    @last_update_at = Gosu::milliseconds

    @particle.update particle_timer
    @particle.x, @particle.y = @x + 10, @y + 10
  end

  def update
    particle_calc

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
