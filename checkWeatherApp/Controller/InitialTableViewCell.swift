//
//  InitialTableViewCell.swift
//  checkWeatherApp
//
//  Created by MACBOOK PRO on 11/28/22.
//

import Foundation
import UIKit

class initialTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    
    func setData(model : CityDb){
        cityLabel.text = model.cityName
        countryLabel.text = model.countryName
    }
}
