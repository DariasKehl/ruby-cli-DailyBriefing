class DailyBriefing::ForecastObject
    #attr_accessor :rep24, :temp24, :con24

  def initialize(r24, r24_2, temp24, temp24_2, con24, con24_2, r48, r48_2, t48, t48_2, con48, con48_2)
    
    puts ""
    puts "Extended Forecast -- 12Hr Blocks"
    puts "-------------------------------------------------" #   x50
      puts "#{r24} -- Temp: #{temp24}, Conditions: #{con24}"
    puts "#{r24_2} -- Temp: #{temp24_2}, Conditions: #{con24_2}"
    puts "#{r48} -- Temp: #{t48}, Conditions: #{con48}"
    puts "#{r48_2} -- Temp: #{t48_2}, Conditions: #{con48_2}"
    puts ""
    puts "*further functionality next"
    puts ""
    puts ""
    puts "Only pressing '2' will save you now. (Because bad UI; mostly.)"
    puts "-------------------------------------------------" #   x50
      

  end
end
