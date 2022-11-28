//
//  InitialTableViewCell.swift
//  checkWeatherApp
//
//  Created by MACBOOK PRO on 11/28/22.
//

import Foundation
import UIKit

class initialTableViewCell: UITableViewCell {

    @IBOutlet var txt_title: UILabel!
    @IBOutlet var txt_subtitle: UILabel!

    
    func setData(model : CityDb){
        txt_title.text = model.cityName
        txt_subtitle.text = model.countryName
    }
    
}
