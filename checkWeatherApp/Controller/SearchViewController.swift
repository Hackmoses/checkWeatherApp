//
//  SearchViewController.swift
//  checkWeatherApp
//
//  Created by MACBOOK PRO on 11/28/22.
//

import Foundation
import UIKit

class SearchViewController: UITableViewController,UISearchBarDelegate,ServiceDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var cityList : [String] = [String]()
    
    
    override func viewDidLoad() {
        searchBar.delegate = self
        activityIndicator.hidesWhenStopped = true
        super.viewDidLoad()
    }
    
    func ServiceDelegateDidFinishWithList(list: [String]) {
        DispatchQueue.main.async {
            self.cityList = list
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print(searchText)
        Service.shared.delegate = self
        self.activityIndicator.startAnimating()
        Service.shared.fetchJSONData(searchText: searchText, completionHandler: { error in
       
            
            if let error = error {
                print("error:\(String(describing: error.localizedDescription))")
                print(error)
                return
            }
        }
        )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cityList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        
        let array = cityList[indexPath.row].components(separatedBy: ",")
        if(array.count>1){
            print(cityList[indexPath.row])
            cell.textLabel?.text = array[0]
            cell.detailTextLabel?.text = array[2]
        }else{
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let array = cityList[indexPath.row].components(separatedBy: ",")
        print(array[0])
        save(city: array[0], country: array[2])
        
    }
    
    func save(city:String,country:String){
        
        let alert = UIAlertController.init(title: "Add \(city) ?", message: "Are you sure you want to add \(city) into your phone ?", preferredStyle: .alert)
        var textField = UITextField()
        
        let action = UIAlertAction.init(title: "Add", style: .default) { (action) in
            
            CoreDataManager.shared.insertCity(city: city,country:country)
            self.tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
            //self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
