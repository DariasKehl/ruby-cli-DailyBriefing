class DailyBriefing::WeatherObject
    attr_accessor :cityState, :currentTemp, :condition, :tMin, :tMax, :reportTime, :groundPressureHPa,
     :windDirection, :windSpeed, :sunUp, :sunDown
    
    def initialize(locName, time, temp, tMin, tMax, gndPres, condition, windDir, windSpd, sunUp, sunDown
        )
        @cityState = locName
        @currentTemp = temp
        @reportTime = time
        @groundPressureHPa = gndPres
        @tMin = tMin
        @tMax = tMax
        @condition = condition
        @windDirection = windDir
        @windSpeed = windSpd
        @sunUp = sunUp
        @sunDown = sunDown
        #try API call for Data with location   
    end
end
