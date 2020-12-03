class DailyBriefing::WeatherObject
    attr_accessor :zipcode, :cityState, :currentTemp, :condition, :tMin, :tMax, :reportTime, :groundPressureHPa,
     :windDirection, :windSpeed, :sunUp, :sunDown, :r24, :r24_2, :temp24, :temp24_2, :con24, :con24_2, :r48, :r48_2, :t48, :t48_2, :con48, :con48_2
    
    def initialize(zipcode, locName, time, temp, tMin, tMax, gndPres, condition, windDir, windSpd, sunUp, sunDown, r24, r24_2,
        temp24, temp24_2, con24, con24_2, r48, r48_2, t48, t48_2, con48, con48_2
        )
        @zipcode = zipcode
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
        @r24 = r24
        @r24_2 = r24_2
        @temp24 = temp24
        @temp24_2 = temp24_2
        @con24 = con24
        @con24_2 = con24_2
        @r48 = r48
        @r48_2 = r48_2
        @t48 = t48
        @t48_2 = t48_2
        @con48 = con48
        @con48_2 = con48_2


        #try API call for Data with location   
    end
end
