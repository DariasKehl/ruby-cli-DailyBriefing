
#  api.openweathermap.org/data/2.5/weather?id=524901&appid=ffe7cb9143aff0778bf7788d0d2a3042
# --   Woot! This thing works!  
# -- name: rubyKey 
# -- key:  ffe7cb9143aff0778bf7788d0d2a3042

class DailyBriefing::APIHandler
    attr_accessor :location, :location_name, :condition, :response_code, :report_time, :temp, :tMin, :tMax, :lat, :lon,
     :gndPres, :windDir, :windSpd, :sunUp, :sunDown, :hr24_dt, :hr24_2_dt, :hr48_dt, :hr48_2_dt, :hr72_dt, :temp24, :temp24_2, 
     :temp48, :temp48_2, :temp72, :con24, :con24_2, :con48, :con48_2

    def initialize(inputLocation)
        @location = inputLocation
    end

  def self.getWeatherDataByLocation(inputLocation) # receives location, sneds back weather object
    response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?zip=#{inputLocation}&appid=ffe7cb9143aff0778bf7788d0d2a3042&units=metric")
    parsed = response.parsed_response
    @current = self.new(inputLocation)
    #puts parsed
    @current.response_code = parsed["cod"]

    # Check for invalid entry
    if @current.response_code === "404"
      puts "\n\nInvalid location, please enter a valid location.\n\n"
      return
    else
      # Assign attributes to current weather object
      @current.location_name = parsed["name"]
      @current.report_time = Time.at(parsed["dt"])
      @current.temp = parsed["main"]["temp"]
      @current.lat = parsed["coord"]["lat"]
      @current.lon = parsed["coord"]["lon"]
      @current.tMin = parsed["main"]["temp_min"]
      @current.tMax = parsed["main"]["temp_max"]
      @current.gndPres = parsed["main"]["sea_level"]
      @current.condition = parsed["weather"].first["description"]
      @current.windDir = parsed["coord"]["lon"]
      @current.windSpd = parsed["coord"]["lon"]
      @current.windDir = parsed["wind"]["deg"]
      @current.windSpd = parsed["wind"]["speed"]
      @current.sunUp = Time.at(parsed["sys"]["sunrise"])
      @current.sunDown = Time.at(parsed["sys"]["sunset"])
    
=begin

attr_accessor :cityState, :currentTemp, :condition, :tMin, :tMax, :reportTime, :groundPressureHPa,
                    :windDirection, :windSpeed
    Changed in design
    def initialize(locName, time, temp, tMin, tMax, gndPres, condition, windDir, windSpd
    
=end

      weatherObj = DailyBriefing::WeatherObject.new(@current.location_name, @current.report_time, @current.temp, @current.tMin, @current.tMax, 
      @current.gndPres, @current.condition, @current.windDir, @current.windSpd, @current.sunUp, @current.sunDown)
      
      
    end
    puts @current.location_name + " weather data retrieved. "
    return weatherObj
  end

    def self.forecast(location)
      
      response = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?zip=#{location}&appid=ffe7cb9143aff0778bf7788d0d2a3042&units=metric")
      parsed = response.parsed_response
      
      #(:loc, :con24, :con48, :con72, :tH24, :tH48, :tH72, :tL24, :tL48, :tL72)
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
