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

    if id == Gosu::KbF2
      if @toggle_ai == false
        @toggle_demo = false
        @toggle_ai = true
      elsif @toggle_ai == true
        @toggle_ai = false
        @paddle_right.velocity = 0
      end
    end

    if id == Gosu::KbF3
      if @toggle_demo == false
        @toggle_ai = false
        @toggle_demo = true
      elsif @toggle_demo == true
        @toggle_demo = false
        @paddle_right.velocity = 0
        @paddle_left.velocity = 0
      end
    end

    if id == Gosu::KbF4
      if @bouncing_ball.in_play? == false
        if @toggle_ee == false
          @toggle_ee = true
          summon_ball_type(self, 40, 250)
        elsif @toggle_ee == true
          @toggle_ee = false
          summon_ball_type(self, 40, 290)
        end
      end
    end

    if id == Gosu::KbSpace
      if @bouncing_ball.in_play? == false
        @bouncing_ball.serve = true
      end
    end

    if id == Gosu::KbF5
      @score.clear
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
