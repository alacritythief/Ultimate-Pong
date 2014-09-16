class Scoreboard
  attr_accessor :player_left, :player_right

  def initialize(window)
    @score_image = Gosu::Font.new(window, "helvetica", 25)
    @player_left = 0
    @player_right = 0
  end

  def draw
    @score_image.draw("P1: #{@player_left}     P2: #{@player_right}", 335, 10, 0, 1.0, 1.0, 0xffffffff)
  end

  def clear
    @player_left = 0
    @player_right = 0
  end
end
