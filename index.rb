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
    window :title => "Setting" do
      title "Setting"  
    end
    @main.close
  end

  @records.click do

  end

end