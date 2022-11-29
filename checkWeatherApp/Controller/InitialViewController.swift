//
//  InitialViewController.swift
//  checkWeatherApp
//
//  Created by MACBOOK PRO on 11/28/22.
//

import Foundation
import CoreData
import UIKit

//Instance of the Database
var allCity : [CityDb] = [CityDb]()

class InitialViewController: UITableViewController,NSFetchedResultsControllerDelegate, UISearchBarDelegate {

    @IBOutlet var btn_add: UIBarButtonItem!
    
    @IBOutlet var searchBar: UISearchBar!
    
    //var dataController : DataController!

    
    var fetchedResultsController: NSFetchedResultsController<CityDb>!
        
    var myFetchResultsController = CoreDataManager.shared.myFetchResultsController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchAllCity()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        setUpFetchedResultController()
        // Do any additional setup after loading the view.
       // self.tableView.register(initialTableViewCell.self, forCellReuseIdentifier: "cell")
       
    }

   override func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
     
           return fetchedResultsController.sections?.count ?? 1
       

   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of rows
        setUpFetchedResultController()
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
       
       
   }
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Clickecd on : \(indexPath.row)")
        let weatherViewController = storyboard?.instantiateViewController(identifier: "WeatherViewController") as? WeatherViewController
        weatherViewController?.city =
        fetchedResultsController.object(at: indexPath).cityName
       self.navigationController?.pushViewController(weatherViewController!, animated: true)
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("loaded :\(indexPath)")
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! initialTableViewCell
      
    cell.setData(model: fetchedResultsController.object(at: indexPath))
    return cell
     
   }
   

   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
        print("\(fetchedResultsController.object(at: indexPath))")
          CoreDataManager.shared.deleteCity(city: fetchedResultsController.object(at: indexPath))
            //fetchAllCity()
           
       }
   }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 1
      }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        setUpFetchedResultController()
       // fetchAllCity()
        tableView.reloadData()
    }
    /*
    func fetchAllCity()
    {
        
        allCity = CoreDataManager.shared.fetchCityFromCoreData()
        tableView.reloadData()
    }
    */
    //Set up a fetch Controller
    func setUpFetchedResultController(){
        
        let fetchRequest : NSFetchRequest<CityDb> = CityDb.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "cityName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let newContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataController = appDelegate.dataController
         */
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: newContext, sectionNameKeyPath: "cityName", cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try? fetchedResultsController.performFetch()
        } catch {
            fatalError("Request failed:\(error.localizedDescription)")
        }
        
        
        
}
    

}
extension InitialViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == ""){
            //try? myFetchResultsController.performFetch()
           // tableView.reloadData()
            //fetchAllCity()
            setUpFetchedResultController()
        }
        else {
           // allCity = CoreDataManager.shared.search(text: searchText)
            setUpFetchedResultController()
            tableView.reloadData()

        }
    }
    
    
}
    

