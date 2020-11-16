class DailyBriefing::CLI
      #@location = ZIP
    # Just kidding - that's a fucking secret; apparently. 
    @@location = "00501"
    @@input = ""

    # 00501 (Holtsville NY River; IRS) - 99950 (Ketchikan, AK)

    #attr_accessor  
    def call #so far this is effectively "main"
      #puts "Welcome to the Greeting"
      userLocationInput = start #this might make ruby vomit *EDIT* Ruby didn't vomit.  
      @@location = userLocationInput
      currentWeather = DailyBriefing::APIHandler.getWeatherDataByLocation(userLocationInput)
      #current weather = send loc to api, and then receive a weather obj
      dispBriefing(currentWeather)
      secondMenu(@@location)
    end

    def start # returns the location
      puts ""
      puts ""
      puts ""
      puts "Welcome to DailyBriefing"
      puts ""
      puts ""
      puts "Please enter your location - 5 digit US zip code."
      
      return getUserLocation
      
    end

    def getUserLocation 
      puts ""
      return gets.chomp #string 
      # THIS IS BAD AND YOU KNOW BETTER
      #
      # Sanitize this input. 
    end

      
      

=begin  
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
    def dispBriefing(currentReport)
      #Temp line will need line padding math for different integers or single line view to keep box
      #City can pull from the API data received
      #Temps can be assembled into spaced strings. 
      #binding.pry

#  ::WeatherObject
#  attr_accessor :cityState, :currentTemp, :tMin, :tMax, :reportTime, :groundPressureHPa

      puts "-------------------------------------------------" #   x50
      puts "|  Zip:  #{@@location}                           " # | x48 spaces between |
      puts "|  City: #{currentReport.cityState}              "
      puts "|                                                "
      puts "|  Temp ºC:  #{currentReport.currentTemp}  --  Low: #{currentReport.tMin}  --  High: #{currentReport.tMax} "
      puts "|  Current condition:  #{currentReport.condition.capitalize}    "
      puts "|"
      puts "|  Wind: #{currentReport.windDirection}º #{currentReport.windSpeed} Kts. "
      puts "|"
      puts "|  Sunrise:  #{currentReport.sunUp}  "  
      puts "|  Sunset: #{currentReport.sunDown} "
      puts "|                                                "
      puts "|                                                "
      puts "|                                                "
      puts "| 1- Ext. Weather  |  2- Exit               "

  
    end

    def secondMenu(l)
      
      userinput = ""
      running = 1
      while running != 0
        userInput = gets.chomp
        if userInput == "1"
          #get extended forecast, display extended forecast. 
          #puts "#{@@location}"
          DailyBriefing::APIHandler.forecast(l)

        elsif userInput == "2"
          puts "Thank you for trying my CLI application. "
          return
        else
          puts "Invalid input.  Try again. 1 or 2. "
        end
      end
    end
end
