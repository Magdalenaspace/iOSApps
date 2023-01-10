//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var searchtextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchtextField.delegate = self /*delegate means representativ*/
    }


    @IBAction func searchPressed(_ sender: UIButton) {
        searchtextField.endEditing(true)
        print(searchtextField.text!)
    }
    
    func textFieldShouldClear(_textFiel:UITextField) -> Bool{
        if searchtextField.text != "" {
            return true
        } else {
            searchtextField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_textField: UITextField) {
        searchtextField.text = ""
    }
}

