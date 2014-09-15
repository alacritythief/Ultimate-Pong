module Keys
  def button_down(id)
    if id == Gosu::KbW
      @paddle_left.velocity += -7
    end

    if id == Gosu::KbS
      @paddle_left.velocity += 7
    end

    if id == Gosu::KbI
      @paddle_right.velocity += -7
    end

    if id == Gosu::KbK
      @paddle_right.velocity += 7
    end

    if id == Gosu::KbM
      #multiball
    end

    if id == Gosu::KbG
      if @toggle_ai == false
        @toggle_demo = false
        @toggle_ai = true
      elsif @toggle_ai == true
        @toggle_ai = false
        @paddle_right.velocity = 0
      end
    end

    if id == Gosu::KbT
      if @toggle_demo == false
        @toggle_ai = false
        @toggle_demo = true
      elsif @toggle_demo == true
        @toggle_demo = false
        @paddle_right.velocity = 0
        @paddle_left.velocity = 0
      end
    end

    if id == Gosu::KbSpace
      if @bouncing_ball.in_play? == false
        @bouncing_ball.serve = true
      end
    end
  end

  def button_up(id)
    if id == Gosu::KbW
      @paddle_left.velocity += 7
    end

    if id == Gosu::KbS
      @paddle_left.velocity += -7
    end

    if id == Gosu::KbI
      @paddle_right.velocity += 7
    end

    if id == Gosu::KbK
      @paddle_right.velocity += -7
    end
  end
end
