module Pomodoro
  @seconds = 1500
	@paused = false

	def display_time
		@display.clear do
			title "%02d:%02d" % [
			  #@seconds / (60 * 60), show hours
			  @seconds / 60 % 60,	
			  @seconds % 60
			] , :stroke => @paused ? gray : black
		end
	end

	@display = stack :margin => 10
	display_time

	button "Interruption", :width => '50%' do
  	@paused = !@paused
	  display_time
	end

  animate(1) do
	  @seconds -= 1 unless (@paused || @seconds == 0)
	  display_time
  end

end