//
//  ViewController.swift
//  TrafficLights
//
//  Created by Rihards Zīverts on 27/04/2020.
//  Copyright © 2020 Rihards Zīverts. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundSwitch: UISwitch!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var trafficLight: UIView!
    @IBOutlet var mainView: UIView!
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        showTimePicker()
        showTrafficLight()
        changeBgColor()
    }
    
    // Allows user to pick time between 06:00 and 24:00
    func showTimePicker() {
        timePicker.datePickerMode = .time
        dateFormatter.dateFormat =  "HH:mm"
        
        let minHour = dateFormatter.date(from: "6:00")
        let maxHour = dateFormatter.date(from: "23:59")
        
        timePicker.minimumDate = minHour
        timePicker.maximumDate = maxHour
    }
    
    // Sencds the new time to traffic light
    @IBAction func selectTime(_ sender: Any) {
        showTrafficLight()
    }
    
    // Change switch status for main view background
    @IBAction func changeSwitchStatus(_ sender: UISwitch) {
        changeBgColor ()
    }
    
    // Change background color depending on switch status
    func changeBgColor () {
        if backgroundSwitch.isOn == true {
            mainView.layer.backgroundColor = UIColor.darkGray.cgColor
        } else {
            mainView.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    // Displays traffic light with the right color
    func showTrafficLight() {
        
        // Traffic light elements
        trafficLight.layer.cornerRadius = trafficLight.frame.size.width / 2
        trafficLight.layer.borderWidth = 3
        trafficLight.layer.borderColor = UIColor.black.cgColor
        
        // Setting up the color change algorithm
        let selectedTime = dateFormatter.string(from: timePicker.date)
        let trafficLights = ["Orange": 1, "Green": 2, "Red": 3]
        var thirdColor = "Orange"
        var secondColor = "Red"
        var firstColor = "Orange"
        var currentColor = "Green"
        var currentHour = 6
        var currentMinute = 0
        var colorChange = 0
        
        // Going through minutes from 06:00 am to 11:59 pm
        for minute in 0...1079 {
            
            // Hour +1 when 60 minutes are reached
            if minute % 60 == 0 && minute != 0 {
                currentHour = currentHour + 1
                currentMinute = 0
                
            // If minute is not zero, adding one minute
            } else if minute != 0 {
                currentMinute = currentMinute + 1
            }
            
            // Changing color depending on trafficLights values next to color titles
            if minute == colorChange + trafficLights[currentColor]! {
                (currentColor, firstColor, secondColor, thirdColor) = (firstColor, secondColor, thirdColor, currentColor)
                colorChange = minute
            }
            
            // Getting the right traffic light color when different time is selected
            if selectedTime == String(format: "%02d", currentHour) + ":" + String(format: "%02d", currentMinute) {
                
                // Should be 'trafficLight.layer.backgroundColor = currentColor without switch statement. Didn't work.
                switch currentColor {
                case "Green":
                    trafficLight.layer.backgroundColor = UIColor.green.cgColor
                case "Orange":
                    trafficLight.layer.backgroundColor = UIColor.orange.cgColor
                case "Red":
                    trafficLight.layer.backgroundColor = UIColor.red.cgColor
                default:
                    print(print(currentColor + " is not included"))
                }
                
            }
        }
    }
}

