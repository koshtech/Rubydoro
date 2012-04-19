require 'rubygems'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "",
  :database => "rubydoro"
)

require File.expand_path('../task',__FILE__)

Shoes.app :title => "Rubydoro" do
  background darkred

  @main = stack do
    title code("Rubydoro"), :stroke => white 
    @start = button "Start your day"
    @records = button "See your records"
  end

  @start.click do
    window :title => "Plan your day" do
      background darkred
      title "Things to do today", :stroke => white
      
      @task = Task.new
      @task.text = edit_line
      @task.save

      button "Add" do
        stack do
          flow do
            para "#{@task.id} - "
            para @task.text
            @gopomodoro = button "Go Pomodoro"
          end
        end
      end
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
end
