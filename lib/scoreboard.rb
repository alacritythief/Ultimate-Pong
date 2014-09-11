class Scoreboard
  attr_accessor :player_left, :player_right

  def initialize(window)
    @score_image = Gosu::Font.new(window, Gosu::default_font_name, 20)
    @player_left = 0
    @player_right = 0
  end

  def draw
    @score_image.draw("Left: #{@player_left} -- Right: #{@player_right}", 330, 10, 0, 1.0, 1.0, 0xffffff00)
  end
end
