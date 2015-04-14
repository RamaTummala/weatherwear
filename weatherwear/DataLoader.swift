//
//  DataLoader.swift
//  weatherwear
//
//  Created by Naga Suman kanagala on 4/5/15.
//  Copyright (c) 2015 Rama Tummala. All rights reserved.
//

import Foundation

struct WeatherData
{
    var cityName: String
    //var weathericon:UIimage
    //var cityGeo: CLLocationCoordinate2D
    var temperature: Float // C
    var humidity: Float // %
    var pressure: Float /// var Israin : String
    // var condition:Int
       var rainfall: String
    // var rainfall : Int
    var jsonDate : Double
    //  var date:Double
    var forecastTime: String
   var id :String
   var icon:String
   var image:UIImageView
    init(data: NSDictionary) {
        
        // Parameters for Current Weather
     /*  cityName = data["name"] as String
        
        let coord: NSDictionary = data["coord"] as NSDictionary
        //cityGeo = CLLocationCoordinate2DMake(coord["lat"].doubleValue, coord["lon"].doubleValue)
        
        let main:NSDictionary = data["main"] as NSDictionary
        temperature = (main["temp"]?.floatValue)! - 273.15 // to convert from Kelvin to Celcius
        humidity = (main["humidity"]?.floatValue)!
        pressure = (main["pressure"]?.floatValue)!
        
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-YY" // 'at' HH:mm""HH:mm"
        jsonDate = (data["dt"]?.doubleValue)!
        
        let date = NSDate(timeIntervalSince1970: jsonDate)
        forecastTime = dateFormatter.stringFromDate(date)
        NSLog("Date: \(forecastTime).")
        
        let weather:NSArray = data["weather"] as NSArray
        let    weatherinfo:NSDictionary = weather[0] as NSDictionary
        // let   cloudiness:NSDictionary = weatherinfo["main"] as NSDictionary
        //    rainfall = (weatherinfo["main"] as String)
        icon = (weatherinfo["icon"] as String)
        id = (weatherinfo["id"]?.integerValue)!
        
        NSLog("weather: \(weatherinfo).")
        // NSLog("rainfall: \(rainfall).")
        
        println("sucess")*/
        // Parameters for 7 Day Forecast
       let city:NSDictionary = data["city"] as NSDictionary
        
        cityName = city["name"] as String
      //   cityName = data["name"] as String
         NSLog("cityName: \(cityName).")
        
        
              let list:NSArray = data["list"] as NSArray
        let Day1:NSDictionary = list[0] as NSDictionary
        
      //  let main:NSDictionary = Day1["main"] as NSDictionary
        let temp:NSDictionary = Day1["temp"] as NSDictionary
        temperature = (temp["min"]?.floatValue)! - 273.15 // to convert from Kelvin to Celcius
        NSLog("temp: \(temperature).")
        humidity = (Day1["humidity"]?.floatValue)!
        pressure = (Day1["pressure"]?.floatValue)!
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-YY" // 'at' HH:mm""HH:mm"
        jsonDate = (Day1["dt"]?.doubleValue)!
        
        let date = NSDate(timeIntervalSince1970: jsonDate)
        forecastTime = dateFormatter.stringFromDate(date)
        NSLog("Date: \(forecastTime).")
        
        let weather:NSArray = Day1["weather"] as NSArray
        let weatherinfo:NSDictionary = weather[0] as NSDictionary
           rainfall = (weatherinfo["main"] as String)
        icon = (weatherinfo["icon"] as String)
        id = (weatherinfo["description"]as String )
        
      /*  if (id==500)
        {
            image = sunny.png
        }*/
    }
}

class DataLoader {
    
     let apiKey = "ed10edb4951497a013623bbab417a459"
    
    // let apiKey = "4f62abb283ead7e46e4ffa41d7fc0c7c"
    
    //ed10edb4951497a013623bbab417a459
    var requestData: NSMutableData? = nil
    var isLoading: Bool = false
    
    private func loadData(query: String, closure: ((json: NSDictionary?) -> Void) ) {
        isLoading = true
        let endpoint = "http://api.openweathermap.org"
   // let path = "/data/2.5/weather?" + query.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
          let path = "/data/2.5/forecast/daily?" + query.stringByReplacingOccurrencesOfString(" ", withString: "-")
        
        // Create request
        let url = NSURL(string: endpoint + path)
        var request = NSMutableURLRequest(URL: url!)
        
        // Start session
       
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler:{
            data, response, error -> Void in
            
            if let data:NSData = data {
                
                // Create string and dictionary from NSData
                var dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                if dataString?.length > 0
                {
                    NSLog("Data: \(dataString).")
                    //  NSLog("Data: \  data["weather"]")
                    var err: NSError?
                    var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                    if let error = err {
                        NSLog("Error: \(error.localizedDescription)")
                    }
                    else {
                        
                       /* if (jsonResult["message"] != nil)
                        {
                            println("data retrieved1")
                           // NSLog(jsonResult["message"] as String)
                            println("data retrieved2")
                        }
                        else
                        {*/
                            closure(json: jsonResult)
                            println("data closed")
                            return
                       // }
                    }
                }
            }
            
            closure(json: nil)
        })
        
        task.resume()
    }
    
    func getDataByCity(city: String, closure: (weather: WeatherData?) -> Void)
    {
        // Example: http://api.openweathermap.org/data/2.5/weather?q=London
        self.loadData("q=\(city)", closure: {
            (json: NSDictionary?) -> Void in
            
            var result:WeatherData?
            if let weatherData = json
            {
                result = WeatherData(data: weatherData)
                
            }
            closure(weather: result)
        })
    }
    
    //    }
}