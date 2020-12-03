class DailyBriefing::CLI
    @@QUIT = nil
    @@weatherReports = []

    # 00501 (Holtsville NY River; IRS) - 99950 (Ketchikan, AK)
    def call #so far this is effectively "main"
      
      while !@@QUIT do
        
        start #keyboard input
        currentWeather = nil
        while !currentWeather do
          @@userLocationInput = getUserLocation
          currentWeather = DailyBriefing::APIHandler.getWeatherDataByLocation(@@userLocationInput)
        end
        ## current weather = send loc to api, and then receive a weather obj
        @@weatherReports.push(currentWeather)
        dispBriefing(currentWeather)
        secondMenu(currentWeather)
      end
    end

    def start # returns the location -> string, numerical, zip range. 
      puts ""
      puts ""
      puts "Welcome to DailyBriefing"
      puts ""
      puts ""
      puts "Please enter your location - 5 digit US zip code only."
      return 
    end

    def getUserLocation ## This is better.  Does it memleak because it's recursive?   no, all the inputs should peel.
      puts ""
      input = gets.chomp
      if  input.to_i >= 00501 && input.to_i <= 99950
        return input
      else
        puts "Invalid -- Please follow provided simple instructions."
        getUserLocation
      end
    end
    
    def secondMenu(currentWeather)
        userInput = gets.chomp
        if userInput == "1"
          #get extended forecast, display extended forecast. 
          forecast(currentWeather)
          return
        elsif userInput == "2"
          puts "Thank you for trying my CLI application. "
          @@QUIT = 1
          return
        elsif userInput == "3"
          #call  # This does recursively cascade.  3, 2 requires TWO enters to get to command prompt.
          # FIX: Effectively, this is nop(), and falls through to the while loop IN call.
          return
        elsif userInput == '4'
          printReports
        elsif userInput == '5'
        puts "EASTER EGG!"
        printReportsInAlphOrder
      end
  end
  
  def dispBriefing(currentReport)
    puts "-------------------------------------------------" #   x50
    puts "|  Zip:  #{currentReport.zipcode}                           " # | x48 spaces between |
    puts "|  City: #{currentReport.cityState}              "
    puts "|                                                "
    puts "|  Temp ºC:  #{currentReport.currentTemp}  --  Low: #{currentReport.tMin}  --  High: #{currentReport.tMax} "
    puts "|  Current condition:  #{currentReport.condition.capitalize}    "
    puts "|"
    puts "|  Wind: #{currentReport.windDirection}º #{currentReport.windSpeed} Kts. "
    puts "|"
    puts "|  Sunrise:  #{currentReport.sunUp}  "  
    puts "|  Sunset:   #{currentReport.sunDown} "
    puts "|                                                "
    puts "|                                                "
    puts "|                                                "
    puts "| 1- Ext. Weather  |  2- Exit  |  3- Restart     "
    puts "| 4- All Reports |5- Alph. Reports  "
  end

  def forecast(currentReport)
    puts ""
    puts "Extended Forecast -- 12Hr Blocks"
    puts "-------------------------------------------------" #   x50
    puts "#{currentReport.r24} -- Temp: #{currentReport.temp24}, Conditions: #{currentReport.con24}"
    puts "#{currentReport.r24_2} -- Temp: #{currentReport.temp24_2}, Conditions: #{currentReport.con24_2}"
    puts "#{currentReport.r48} -- Temp: #{currentReport.t48}, Conditions: #{currentReport.con48}"
    puts "#{currentReport.r48_2} -- Temp: #{currentReport.t48_2}, Conditions: #{currentReport.con48_2}"
    puts ""
    puts ""
    puts ""
    puts ""
    puts "| 1- Ext. Weather  |  2- Exit  |  3- Restart       "
  end

  def printReports
    @@weatherReports.each  do |r|
      dispBriefing(r)
      forecast(r)
    end
  end

  def printReportsInAlphOrder
    sortedArray = @@weatherReports.sort_by do |a|
      a.cityState
    end
    sortedArray.each do |zxc| 
      dispBriefing(zxc)
      forecast(zxc)
    end
  end
end

=begin
## Outside file. 


mainLoop

Is there a location? 
No?  Get location
Yes
Display Briefing

menu -> 
1.  ext. forecast
2.  Exit
3.  change location
  
    ## Execution process

    App Start
    [ ] Ask user for location information.
    -- Greeeting menu
    -- Prompt for Zip
    -- Get zip code
      oo perform some manner of data verification?  
    -- give zip code to.... where - DailyBriefing::APIHandler -> getWeatherByLocation
      -- that should create a weather object that vomits up *real* weather data to the
          CLI 
    [ ] Display Briefing. Prompt for more input
      -- Show the location entered and the basic daily weather data
    [ ] Additional Input can be Extended Weather, Change Loc, Quit. 

    ## Basic Execution complete.  Modular design will allow additional packages to be added in. 
    
=end 