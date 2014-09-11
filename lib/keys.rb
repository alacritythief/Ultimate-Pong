module Keys
  def button_down(id)
    if id == Gosu::KbW
      @paddle_left.velocity += -6
    end

    if id == Gosu::KbS
      @paddle_left.velocity += 6
    end

    if id == Gosu::KbI
      @paddle_right.velocity += -6
    end

    if id == Gosu::KbK
      @paddle_right.velocity += 6
    end

    if id == Gosu::KbG
      if @toggle_ai == false
        @toggle_ai = true
      elsif @toggle_ai == true
        @toggle_ai = false
        @paddle_right.velocity = 0
      end
    end
  end

  def button_up(id)
    if id == Gosu::KbW
      @paddle_left.velocity += 6
    end

    if id == Gosu::KbS
      @paddle_left.velocity += -6
    end

    if id == Gosu::KbI
      @paddle_right.velocity += 6
    end

    if id == Gosu::KbK
      @paddle_right.velocity += -6
    end
  end
end
