import Foundation
import CoreLocation


//external internal parametrs
//esternal parameter when we uuse outside of func to call, like so myFunc(external: -value) ---> ca n be done so myFunc(_ internal:Type)
//internal is when we use the value  within the func
//print(internal) -> for making code readble -> _, with

//we can extend the protocol and provide defauult behavior of required methods
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
//we create protocol in the same file as the class yhat it is being used

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=88dc5876ebaaaadc91b84cfa33c72bd6&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {  //get te data
        let urlString = "\(weatherURL)&q=\(cityName)" //cuting the weatherURL and making more responsive
        performRequest(with: urlString)
    }
    
    
   // we send datatypes here we  get hold of it angd get string let to be able to have the current place 
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    //networking = the API Request Response
    func performRequest(with urlString: String)  {   //<- complition handler
        //1 create URL, Optional begauuse textfiled?
        if let url = URL(string: urlString) {
            //2 URL session
            let session = URLSession(configuration: .default) //.default is what lets the browder work
            //3 give a task
            let task = session.dataTask(with: url) { (data, response, error) in  //<- triling clouser( function as the function's final argument)
                if error != nil {  //<- good place to catch error
                    self.delegate?.didFailWithError(error: error!) //inside the clousere self comes
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    } //when we inside we always need to use self
                }
                
                //indtead the delegate way it coul;d bve dons as so:
                //let weatherVC = WeatherViewController()
                //weatherVC.didUpdateWeather(weather) <- this func gets created at weatherViewController (weather:weatherVC) but this will render as a single use------> try not use a specific code that tyes another object
                
            }
            // hit the go
            task.resume()
        }
    }
    //Data type coming from dataTask() _>
    //in order to parse the data from the Json format  we have to
    //inform the compiler how the weathr Data is structured
    
        //we make model optional so we can return nil, and we unrap it in above
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        //use decoder to decode -> dtataType not not object, make type the obect with . self -> what data we want to encode it will be the ___ that comes as a data from parameter
        do {
            //because decoder has an output we capyure it in a constant
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData) //we could fail here too beacuse our data transaction
            let id = decodedData.weather[0].id // <- this comes from weatherData struct turned into decodedData
            let temp = decodedData.main.temp
            let name = decodedData.name
            //we done decoding the bneeded data
            
            //here we build and object from WeathetModel
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
//            print(weather.getConditionName(conditionID: id)) < - instead we will create getConditionName
//            print(weather.conditionName)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
  
//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
//            let name = decodedData.name
//
//            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//            return weather
//
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//
//
    
}

