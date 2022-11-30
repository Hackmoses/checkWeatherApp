//
//  ViewController.swift
//  checkWeatherApp
//
//  Created by MACBOOK PRO on 11/25/22.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var city : String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempt: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imgUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()
        activityIndicator.hidesWhenStopped = true
    }
    
    func fetchWeatherData(){
        
        let manager = WeatherService()
        manager.fetchWeatherData(city: city ?? "", completionHandler: {
            
            (data, error) in
            
            if let error = error {
                print("error:\(String(describing: error.localizedDescription))")
                self.activityIndicator.stopAnimating()
                let alert = UIAlertController.init(title: "Connection failed", message: "Check you network connection", preferredStyle: .alert)
                let cancelAction = UIAlertAction.init(title: "Retry", style: .default)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                print(error)
                return
            }
            
            DispatchQueue.main.async { [self] in
                // self.list = employees
                print("data in weather : \(data.name) ")
                // self.tableView.reloadData()
                
                self.activityIndicator.startAnimating()
                self.humidity.text = "\(data.main?.humidity ?? 0.0) ˚C"
                self.tempt.text = "\(data.main?.temp ?? 0.0) ˚C"
                let icon = data.weather[0].icon
                self.imgUrl = "https://openweathermap.org/img/wn/\(icon).png"
                //loadIcon(img:imgUrl)
                self.activityIndicator.stopAnimating()
                imageView.imageFromServerURL(urlString: imgUrl)
                
            }
        }
                                 
                                 
        )
        
    }
    
    
}


extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}


