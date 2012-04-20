Shoes.app :title => "Rubydoro", :width => 300, :height => 160 do
  background darkred

  @main = stack do
    title code("Rubydoro"), :stroke => white, :margin_left => 40, :margin_top => 20
    @start = button "Start your day", :margin_left => 80, :margin_top => 10
  end

  @start.click do
    window :title => "Plan your day", :width => 850, :height => 730 do
      background darkred
      flow do
        title "Things to do today", :stroke => white
      end
      @task = edit_line :width => 400, :margin_left => 10, :margin_top => 10
      @counter = 0
      button "Add", :margin_left => 5, :margin_top => 10 do
        stack do
          @f = flow do
            flow do
              para "------------------------------------------------------------------------------------------------------------------------------------------------------------------------", :stroke => white
            end
            para "#{@counter += 1} ~> ", :stroke => white
            para @task.text, :stroke => white
            para " "
            @task.text = ""
            button "Go Pomodoro" do
              window :title => "Pomodoro", :width => 300, :height => 180 do
                background darkred
                @seconds = 1500
                @paused = false

                def display_time
                  @display.clear do
                    title "%02d:%02d" % [@seconds / 60 % 60, @seconds % 60],
                    :stroke => @paused ? gray : white,
                    :margin_left => 95                    
                  end
                end

                @display = stack
                display_time

                button "Interruption", :width => '100%' do
                  if @paused == false
                    para "* ", :stroke => white, :margin_top => 10
                  end
                  @paused = true
                  display_time 
                end
        
                button "Back to work", :width => '100%' do
                  @paused = false
                  display_time
                end

                para "Interruptions: ", :stroke => white, :margin_top => 10

                animate(1) do
                  @seconds -= 1 unless (@paused || @seconds == 0)
                  display_time
                end
              end

            end

            button "Short Break" do
              window :title => "Short Break", :width => 300, :height => 180 do
                background darkred
                @sbtime = 300
                @p = false

                def display_timesb
                  @displaysb.clear do
                    title "%02d:%02d" % [@sbtime / 60 % 60, @sbtime % 60],
                    :stroke => @p ? gray : white,
                    :margin_left => 95 
                  end
                end

                @displaysb = stack
                display_timesb

                button "Pause", :width => '100%' do
                  @p = true
                  display_timesb
                end
        
                button "Continue break", :width => '100%' do
                  @p = false
                  display_timesb
                end
  
                animate(1) do
                  @sbtime -= 1 unless (@p || @sbtime == 0)
                  display_timesb
                end
              end
            end 

            button "Long Break" do
              window :title => "Long Break", :width => 300, :height => 180 do
                background darkred
                @lbtime = 1800
                @p2 = false

                def display_timelb
                  @displaylb.clear do
                    title "%02d:%02d" % [@lbtime / 60 % 60, @lbtime % 60],
                    :stroke => @p2 ? gray : white,
                    :margin_left => 95 
                  end
                end

                @displaylb = stack
                display_timelb

                button "Pause", :width => '100%' do
                  @p2 = true
                  display_timelb
                end
        
                button "Continue break", :width => '100%' do
                  @p2 = false
                  display_timelb
                end
  
                animate(1) do
                  @lbtime -= 1 unless (@p2 || @lbtime == 0)
                  display_timelb
                end
              end
            end

            button "Done" do
              @f.clear
            end

            flow do
              para "------------------------------------------------------------------------------------------------------------------------------------------------------------------------", :stroke => white
            end
          end
        end
      end
      
      

    end
    @main.close
  end

end
