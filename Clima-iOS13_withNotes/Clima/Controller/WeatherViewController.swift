//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//
//to get hokd of location data we need to iport
import UIKit
import CoreLocation
//comes with the manager so create under outlets

//here this needs to adopt the WeatherManagerDelegate
class WeatherViewController: UIViewController {

  
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var serachTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationMnager = CLLocationManager()
    //to be able to use it we need user autoristaion triggered when uapp loads up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationMnager.delegate = self
        //asks permition loaded from pList(key value pairs -determs basic app setings)
        locationMnager.requestWhenInUseAuthorization()
        //if we need to manitore the location all the time so e use this, contently repors back when it upfates
        //locationMnager.startUpdatingLocation()
        
        
        //can be changed from simulator screen settings
        
        //now we need to track the user location not all time only when app is being active
        locationMnager.requestLocation()
//        we have to adopt this delegate protocol in our WeatherViewController if we want to be able to assign
//        ourselves as the delegate for the locationManager to be notified of that location update.
        
        
        //IMORTANT LOOK at the doqs of request "When using this method, the associated delegate must implement the"
       
        // assign ourselves as the delegate
        //for the locationManager to be notified of that location update.
//        locationMnager.delegate = self   <-------------this will crush vecause is done after the requests
        // Do any additional setup after loading the view.
        serachTextField.delegate = self
        //set the current class as a delegate so weatherManager delegate property will not be nill
        weatherManager.delegate = self
        }
    
    @IBAction func LocationPressed(_ sender: UIButton) {
        locationMnager.requestLocation()
    }
    
}


//MARK: - UITextFieldDelegate

//we aslo can create costume code snepits {} mark right click-> create code snipet with section heading starts with < and # closes the sanme  way -> add coplition mark


// reorgnising code by spliting out some extentions UITextFieldDelegate, WeatherManagerDelegate
extension WeatherViewController: UITextFieldDelegate{
    
    @IBAction func serachPressed(_ sender: UIButton) {
        serachTextField.endEditing(true) //to casel the keboard
//        print(serachTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(serachTextField.text!) //dismises the keyboard
        //triggers go button//return process is being terured tru
        serachTextField.resignFirstResponder()
       
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //this is good to use for validation
        if serachTextField.text != ""{
            return true
        }else{
            textField.placeholder="Type City Name"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    //we will use searchfield.text to get the wether output triiger for the cit input
        if let city = serachTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        
       serachTextField.text = ""
    }
    
}
//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //dispatch q
        
        //if we tring to update th UI from inside complition handler(performs back-end long runing task such as networking, this happens in back-end so we dont block the Ui)
//so before th action compplition to provent app from freezing we shole do this -> an because its closer add self
        DispatchQueue.main.async{
            self.temperatureLabel.text = weather.temperatureString
            //        print(weather.temperature)
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                //systemName ecspects String matching Sf Symbol
            
            self.cityLabel.text = weather.cityName
            //here after using CoreLocation we will ecsses to the name textfield be changed
        }
    }
    func didFailWithError(error: Error) {
        print(error)
        //so we will know swith off the wifi,3g internet...
    }
    
}

//MARK: - WeatherViewController
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("Got Location")
        
        
        //to show were we are located // .last is the last item in array(we do the last location locationManager will try to get the current GPS location and hone in on a relatively accurate version of it, might end up with several locations. By fetching the last location,
        //we should be able to get the most accurate one. But because this locations.last is an optional,)
        
        if let location = locations.last {
            locationMnager.stopUpdatingLocation()
            //<- we did this so we can go back when   LocationPressed gets triggered
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            //by performing this sucsessfuly  it will go  to didUpdateWeather -> WeatherManagerDelegate and update label view and   conditionImage + text field
                // in orfer to work in WeatherManager  imlement it
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
