require 'rubygems'
require 'active_record'
require 'mysql2'

require 'todolist'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "",
  :database => "rubydoro"
)

Shoes.app :title => "Rubydoro" do
  background darkred

  @main = stack :margin => '12' do

    flow :margin => '8' do
      #image "ruby.png", :width => '20%'
      title code("Rubydoro"), :stroke => white 
      #image "pomodoro-technique-21.png", :width => '20%'
    end

    @start = button "Start your day"
    @records = button "See your records"
  end


  @start.click do
    window :title => "Plan your day" do
      background darkred
        # flow do
        #   para "Day: "
        #   @day = edit_line :width => '10%'
        #   para "Month: " 
        #   @month = edit_line :width => '10%'
        #   para "Year: " 
        #   @year = edit_line :width => '10%'
        # end  
      
        # button "Create" do
        #   window do
        #     para @day.text
        #     para @month.text
        #     para @year.text
        #   end
        # end
      
      title "Things to do today", :stroke => white
      @task = edit_line(:width => 230, :margin_left => 10)
      @task_num = 0
      button "Add" do
        stack do
          flow(:margin_left => 7) do
            para "#{@task_num += 1}. "
            para @task.text
            button "Go Pomodoro" do
              window :title => "Pomodoro" do
                background darkred
                @seconds = 1500
                @paused = false

                def display_time
                  @display.clear do
                    title "%02d:%02d" % [
                    @seconds / 60 % 60, 
                    @seconds % 60
                    ] , :stroke => @paused ? gray : white
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

            button "Done" do
              if     

            end
          end
        end
      end 

      #@pomo.click do
        # window :title => "Pomodoro" do
        #   background darkred
        #   @seconds = 1500
        #   @paused = false

        #   def display_time
        #     @display.clear do
        #       title "%02d:%02d" % [
        #       #@seconds / (60 * 60), show hours
        #       @seconds / 60 % 60, 
        #       @seconds % 60
        #       ] , :stroke => @paused ? gray : black
        #     end
        #   end

        #   @display = stack :margin => 10
        #   display_time

        #   button "Interruption", :width => '50%' do
        #     @paused = !@paused
        #     display_time
        #   end

        #   animate(1) do
        #     @seconds -= 1 unless (@paused || @seconds == 0)
        #     display_time
        #   end

        # end
      #end
    end
    @main.close
  end

  # @records.click do

  # end

end