
#  api.openweathermap.org/data/2.5/weather?id=524901&appid=ffe7cb9143aff0778bf7788d0d2a3042
# --   Woot! This thing works!  
# -- name: rubyKey 
# -- key:  ffe7cb9143aff0778bf7788d0d2a3042

class DailyBriefing::APIHandler
    #attr_accessor :location
    
    def initialize(inputLocation)
        @location = inputLocation
    end

  def self.getWeatherDataByLocation(inputLocation) # receives location, sneds back weather object
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?zip=#{inputLocation}&appid=ffe7cb9143aff0778bf7788d0d2a3042&units=metric")
    parsed = response.parsed_response
    #@current = self.new(inputLocation)
    #puts parsed
    response_code = parsed["cod"]

    # Check for invalid entry
    if response_code === "404"
      puts "\n\nInvalid location, please enter a valid location.\n\n"
      return
    else
      # Assign attributes to current weather object
      location_name = parsed["name"]
      report_time = Time.at(parsed["dt"])
      temp = parsed["main"]["temp"]
      lat = parsed["coord"]["lat"]
      lon = parsed["coord"]["lon"]
      tMin = parsed["main"]["temp_min"]
      tMax = parsed["main"]["temp_max"]
      gndPres = parsed["main"]["sea_level"]
      condition = parsed["weather"].first["description"]
      windDir = parsed["coord"]["lon"]
      windSpd = parsed["coord"]["lon"]
      windDir = parsed["wind"]["deg"]
      windSpd = parsed["wind"]["speed"]
      sunUp = Time.at(parsed["sys"]["sunrise"])
      sunDown = Time.at(parsed["sys"]["sunset"])

      ##### Current Weather information API retrieval
      ##### Below is loading of forecast data from second API retrieval
      responseForecast = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?zip=#{inputLocation}&appid=ffe7cb9143aff0778bf7788d0d2a3042&units=metric")
      parsedForecast = responseForecast.parsed_response
      
      hr24_dt = parsedForecast["list"][0]["dt_txt"]
      hr24_2_dt = parsedForecast["list"][4]["dt_txt"]
      hr48_dt = parsedForecast["list"][8]["dt_txt"]
      hr48_2_dt = parsedForecast["list"][12]["dt_txt"]
      
      temp24 = parsedForecast["list"][0]["main"]["temp"]
      temp24_2 = parsedForecast["list"][4]["main"]["temp"]
      temp48 = parsedForecast["list"][12]["main"]["temp"]
      temp48_2 = parsedForecast["list"][16]["main"]["temp"]
      con24 = parsedForecast["list"][0]["weather"][0]["description"].capitalize
      con24_2 = parsedForecast["list"][4]["weather"][0]["description"].capitalize
      con48 = parsedForecast["list"][12]["weather"][0]["description"].capitalize
      con48_2 = parsedForecast["list"][16]["weather"][0]["description"].capitalize
  
      weatherObj = DailyBriefing::WeatherObject.new(location_name, report_time, temp, tMin, tMax, 
      gndPres, condition, windDir, windSpd, sunUp, sunDown, hr24_dt, hr24_2_dt, hr48_dt, hr48_2_dt, temp24, temp24_2, temp48,
      temp48_2, con24, con24_2, con48, con48_2)
      
      
    end
    return weatherObj
  end

    def self.forecast(location)  #method deprecated ?
            
      response = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?zip=#{location}&appid=ffe7cb9143aff0778bf7788d0d2a3042&units=metric")
      parsed = response.parsed_response
      @current = self.new(location)
    
      loc = @current.location_name
      
      #puts "testing location: #{location}"
      #puts parsed
      @current.hr24_dt = parsed["list"][0]["dt_txt"]
      @current.hr24_2_dt = parsed["list"][4]["dt_txt"]
      @current.hr48_dt = parsed["list"][8]["dt_txt"]
      @current.hr48_2_dt = parsed["list"][12]["dt_txt"]
      
      @current.temp24 = parsed["list"][0]["main"]["temp"]
      @current.temp24_2 = parsed["list"][4]["main"]["temp"]
      @current.temp48 = parsed["list"][12]["main"]["temp"]
      @current.temp48_2 = parsed["list"][16]["main"]["temp"]
      @current.con24 = parsed["list"][0]["weather"][0]["description"].capitalize
      @current.con24_2 = parsed["list"][4]["weather"][0]["description"].capitalize
      @current.con48 = parsed["list"][12]["weather"][0]["description"].capitalize
      @current.con48_2 = parsed["list"][16]["weather"][0]["description"].capitalize
    
      extendedForecast = DailyBriefing::ForecastObject.new(@current.hr24_dt, @current.hr24_2_dt, @current.temp24, @current.temp24_2,
       @current.con24, @current.con24_2, @current.hr48_dt, @current.hr48_2_dt, @current.temp48, @current.temp48_2, 
       @current.con48, @current.con48_2)
      #initialize(r24, r24_2, temp24, temp24_2, con24, con24_2, r48, r48_2, t48, t48_2, con48, con48_2)
    

    end
end
