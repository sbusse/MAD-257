//
//  ViewController.swift
//  weatherApp_v2
//
//  Created by student on 9/29/20.
//  Copyright © 2020 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TODO:  This is step 1
        //Tell my function where to look for the weather data
        //
        if let url = NSURL(string: "https://api.darksky.net/forecast/ae58c5fa7285b492f6a553d200018d93/42.3334, 88.2668") {
            if let data = NSData(contentsOf: url as URL) {
                
                //TODO:  This is step 2
                //Parse thru the data
                //
                do {
                    let parsed = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    as! [String:AnyObject]
                    
                    //TODO:  This is step 3
                    //Temporarily store the parsed data in a dictionary
                    //
                    let newDict = parsed
                    
                    //TODO:  This is step 4
                    //Print out these 3 pieces of data in the terminal window to check them.
                    //
                    print(newDict["currently"]!["summary"] as Any)
                    print(newDict["currently"]!["temperature"] as Any)
                    print(newDict["currently"]!["dewPoint"] as Any)
                    
                    self.currentTemp.text = "\(newDict["currently"]!["summary"])"
                    self.currentTemp.text = "\(newDict["currently"]!["temperature"])"
                    self.currentTemp.text = "\(newDict["currently"]!["dewPoint"])"
                }
                //TODO:  This is step 5
                //If you have a problem reading the Json data, print an error
                //
                catch let error as NSError {
                    print("A JSON parsing error occured, here are the details:\n \(error)")
                }
            }
        }
    }
    //TODO:  This is step 6
    //Add the outlets to hold the data
    //

    @IBOutlet weak var currentTemp: UILabel!
    
    
    @IBOutlet weak var currentSummary: UILabel!
    
    
    @IBOutlet weak var currentDewpoint: UILabel!
}

