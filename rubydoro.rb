Shoes.app :title => "Rubydoro" do
  background darkred

  @main = stack do
    title code("Rubydoro"), :stroke => white 
    @start = button "Start your day"
  end

  @start.click do
    window :title => "Plan your day" do
      background darkred
      title "Things to do today", :stroke => white
      
      @task = edit_line :width => 230, :margin_left => 10
      @counter = 0
      button "Add" do
        stack do
          flow do
            para "#{@counter += 1} - "
            para @task.text
            @gopomodoro = button "Go Pomodoro"
            para "[Interruptions: "
            [1..@intcounter].each do
               para "* " 
            end
            para "]"
            @done = button "Done"
          end
        end
      end
      @shortbreak = button "Short Break" 
      @longbreak = button "Long Break"
    end
    @main.close
  end

  @gopomodoro.click do
  	window :title => "Pomodoro" do
      background darkred
      @seconds = 1500
      @paused = false

      def display_time
        @display.clear do
          title "%02d:%02d" % [@seconds / 60 % 60, @seconds % 60] , :stroke => @paused ? gray : white
        end
      end

      @display = stack
      display_time

      button "Interruption", :width => '100%' do
        @paused = true
        display_time
      end
        
      button "Go", :width => '100%' do
        @paused = false
        display_time
      end

      animate(1) do
        @seconds -= 1 unless (@paused || @seconds == 0)
        display_time
      end
    end
  end

  # @shortbreak.click do
  #   window :title => "Short Break" do
  #     background darkred
  #     @sbtime = 300
  #     @p = false

  #     def display_time
  #       @display.clear do
  #         title "%02d:%02d" % [@sbtime / 60 % 60, @sbtime % 60] , :stroke => @p ? gray : white
  #       end
  #     end

  #     @display = stack
  #     display_time

  #     button "Interruption", :width => '100%' do
  #       @p = true
  #       display_time
  #     end
        
  #     button "Go", :width => '100%' do
  #       @p = false
  #       display_time
  #     end

  #     animate(1) do
  #       @sbtime -= 1 unless (@p || @sbtime == 0)
  #       display_time
  #     end
  #   end

  # end
end
