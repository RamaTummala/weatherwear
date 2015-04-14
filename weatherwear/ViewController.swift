//
//  ViewController.swift
//  weatherwear
//
//  Created by Naga Suman kanagala on 4/5/15.
//  Copyright (c) 2015 Rama Tummala. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField?
    
    @IBOutlet weak var IConView: UIImageView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var resultsCard: UIView!
  //  @IBOutlet weak var resultsCard: UIView?
    @IBOutlet weak var resultsCityName: UILabel?
    @IBOutlet weak var resultsTemperature: UILabel?
    @IBOutlet weak var resultsHumidity: UILabel?
    @IBOutlet weak var resultsPressure: UILabel?
   
    @IBOutlet weak var noResults: UILabel?
    @IBOutlet weak var resultRain: UILabel?
    
    @IBOutlet weak var IconResult: UILabel!
    @IBOutlet weak var IDValue: UILabel!
    
    var dataLoader = DataLoader()
  

    
    //  var locationManager: CLLocationManager?
   // var currentLocation: CLLocationCoordinate2D?
 //   var stillUpdatingLocation = false
    
    // MARK: - UIView overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
           }
    
        // MARK: - UI setup
    func loadData(weather: WeatherData?)
    {
        if let weather = weather
        {
            UIView.animateWithDuration(0.3, animations: {
                () -> Void in
                
                //self.resultsCard!.alpha = 1.0
                //self.noResults!.alpha = 0.0
                
                let format = ".1"
                //    Parameters for Current Weather
                NSLog("cityName: \(weather.cityName).")
                self.resultsCityName?.text = weather.cityName
                self.resultsTemperature?.text = NSString(format:"%.1f°", weather.temperature)
                self.resultsHumidity?.text = NSString(format:"%.0f%%", weather.humidity)
                self.resultsPressure?.text = NSString(format:"%.0f hPa", weather.pressure)
                self.DateLabel?.text = weather.forecastTime
                  self.resultRain?.text = weather.rainfall
               self.IconResult?.text = weather.icon
                self.IDValue?.text = weather.id
                
               // if (weather.icon ==)
                //self.weatherIcon
                //  self.resultRain!.text = NSString(format:"%.0f", weather.rainfall)*/
                
                //Parameters for ForeCast Weather
                //     self.resultsCityName!.text = weather.cityName
                
            })
        }
        else
        {
            UIView.animateWithDuration(0.3, animations: {
                () -> Void in
                
               // self.resultsCard!.alpha = 0.0
                self.noResults!.alpha = 1.0
               self.noResults!.text = "No results found"
            })
        }
    }
    
    // MARK: - Search requests
    @IBAction func searchForTheCityTapped(sender: AnyObject) {
        
        var cityName:String? = cityTextField?.text
       // let background = UIImage(named: "sunny.png")
       // self.view.backgroundColor = UIColor(patternImage: background!)

        if (cityName != nil)
        {
            
            dataLoader.getDataByCity(cityName!, closure: {
                (result: WeatherData?) -> Void in
                
                // To update UI on the main thread
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.loadData(result)
                    
                })
            })
        }
    }
    
 }
