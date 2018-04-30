//
//  MasterViewController.swift
//  swiftforandroid
//
//  Created by Darius Bell on 3/9/18.
//  Copyright © 2018 Darius Bell. All rights reserved.
//
import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    let MY_DUMB_URL = "https://api.myjson.com/bins/1ahrbf"
    var franchises = [String]()
    var objectsReturned = [DataObject]()
    var fullData = [[DataObject]]()
    
    //the json file url
    //let URL_HEROES = "https://api.myjson.com/bins/70xp1"
    //the label we create
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let imageView = UIImageView(image:#imageLiteral(resourceName: "Image"))
        //self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.barTintColor=UIColor.darkGray
        getJsonFromUrl()
        //DataController.getJsonFromUrl()
        //        // Do any additional setup after loading the view, typically from a nib.
        //        navigationItem.leftBarButtonItem = editButtonItem
        //
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        //        navigationItem.rightBarButtonItem = addButton
        //        if let split = splitViewController {
        //            let controllers = split.viewControllers
        //            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        //        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        //objects.insert(DataObject(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = fullData[indexPath.section][indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object;
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.franchises.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fullData[section].count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.franchises[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = fullData[indexPath.section][indexPath.row]
        cell.textLabel!.text = object.name
        cell.detailTextLabel?.text = object.yearStart
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    func getJsonFromUrl(){
        //creating a NSURL
        let url = NSURL(string: MY_DUMB_URL)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let allThatData = jsonObj!.value(forKey: "datData") as? NSDictionary{
                    print(allThatData)
                    
                    if let franchiseArray = allThatData.value(forKey: "franchise") as? NSArray{
                        
                        for franchiseDict in franchiseArray{
                            if let franchiseName = (franchiseDict as! NSDictionary).value(forKey:
                                "franchiseName") as? String {
                                self.franchises.append(franchiseName)
                                
                                
                                if let entriesArray = (franchiseDict as! NSDictionary).value(forKey: "entries")
                                    as? NSArray{
                                    self.objectsReturned = []
                                    for entryObject in entriesArray{
                                        
                                        
                                        let thisEntry = DataObject(withObject: entryObject as!
                                            Dictionary<String,AnyObject>)
                                        print(thisEntry.name)
                                        self.objectsReturned.append(thisEntry)
                                    }
                                }
                                
                            }
                            self.fullData.append(self.objectsReturned)
                        }
                    }
                    print(self.fullData)
                }
                
            }
        }).resume()
    }
    
    
    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete {
    //            objects.remove(at: indexPath.row)
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        } else if editingStyle == .insert {
    //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    //        }
    //    }
    
    
    
    
}
