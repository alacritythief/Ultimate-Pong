module Keys
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
