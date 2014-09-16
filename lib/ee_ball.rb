class EeBall
  include BoundingBox
  attr_accessor :x, :y, :vx, :vy, :left, :right, :top, :bottom, :serve, :speed
  attr_reader :quotes

  def initialize(window, x, y)
    @ee_image = ["eric", "adam", "helen", "richard", "faizaan"].sample
    quotes
    @ball_image = Gosu::Image.new(window, "img/#{@ee_image}.png", false)
    @x = x
    @y = y
    @vx = @vy = 0
    @serve = false
    @ball_in_play = false
    @speed = 0

    @ee_quote = Gosu::Font.new(window, "helvetica", 20)

    @particle = Ashton::ParticleEmitter.new 0, 0, 3,
                                           scale: 8,
                                           speed: 1..100,
                                           max_particles: 5000,
                                           offset: 0..50,
                                           interval: 0.0010,
                                           color: Gosu::Color.rgba(255, 20, 147, 50),
                                           fade: 70,
                                           gravity: 0

    bounding(@x, @y, 100, 100)
  end

  def draw
    @particle.draw
    @ball_image.draw(@x, @y, 1)
    @ee_quote.draw_rel("#{@quote}", @x + 50, @y - 30, 0, 0.5, 0, 1.0, 1.0, 0xffffffff)
  end

  def in_play?
    @ball_in_play
  end

  def quotes
    if @ee_image == "eric"
      @quote = ["...Okay.", "...Cool.", "I like cats.", "Vim is awesome"].sample
    elsif @ee_image == "adam"
      @quote = ["Emacs is better.", "Foo.", "Bar.", "I can play Flappy Bird all day"].sample
    elsif @ee_image == "helen"
      @quote = ["OH!", "Neat!", "Great!", "Have a fortune cookie!"].sample
    elsif @ee_image == "richard"
      @quote = ["It's about time I fixed that.", "Uhh...", "Yeah."].sample
    elsif @ee_image == "faizaan"
      @quote = ["Accio Rubinius!", "I'm reading brain waves.", "Voldemort sux eggs."].sample
    end
  end

  def particle_calc
    @last_update_at ||= Gosu::milliseconds
    particle_timer = [Gosu::milliseconds - @last_update_at, 100].min * 0.001
    @last_update_at = Gosu::milliseconds

    @particle.update particle_timer
    @particle.x, @particle.y = @x + 50, @y + 50
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

    if @y > 500
     @vy = -5 + -(speed)
    end

    if @y < 0
      @vy = 5 + speed
    end

    bounding(@x, @y, 100, 100)
  end
end
