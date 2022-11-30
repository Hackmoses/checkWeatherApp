//
//  WeatherService.swift
//  checkWeatherApp
//
//  Created by MACBOOK PRO on 11/28/22.
//

import Foundation
import Foundation


class WeatherService {


    func fetchWeatherData(city:String, completionHandler : @escaping (WeatherModel, Error? )->Void )  {

        /*let stringUrl = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=b4cb98807ba7bc852f39047637f2b59e&units=metric".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
         
         var url = URL(string:stringUrl)!
        
         */
        
        var urlString = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
                var url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(urlString!)&appid=b4cb98807ba7bc852f39047637f2b59e&units=metric")!
                    
                        print(url)
        
                       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                           
                         
                           if let error = error {
                                print("error in url session")
                               print(error)
                               return
                           }
                           
                           // We want to ensure that we have a good HTTP response status
                           guard let httpResponse = response as? HTTPURLResponse,
                               (200...299).contains(httpResponse.statusCode)
                               else {
                                   // Show the URL and response status code in the debug console
                                   if let httpResponse = response as? HTTPURLResponse {
                                       print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                                   }
                                   return
                           }
                          
                               if let data = data {
                               
                               // Create and configure a JSON decoder
                               let decoder = JSONDecoder()
                               decoder.dateDecodingStrategy = .iso8601
                        
                               do {
                                
                                   let result = try decoder.decode(WeatherModel.self, from: data)
                                   
                                   // Diagnostic
                                print("result in url session")
                                print(result)
                               
                                   // Save the data (in memory)
                                completionHandler(result, error)
                              
                                   // Then reload the table view; must be done this way
                                   
                               }
                               catch {
                                    print("error exception in url session")
                                print(error)
                               }
                           }
                       }
                       
                       // Now that "task" has been fully defined, execute it...
                       task.resume()
                  
            }
        
    }

