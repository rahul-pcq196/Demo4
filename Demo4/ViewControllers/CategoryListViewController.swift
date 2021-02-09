//
//  ViewController.swift
//  Demo4
//
//  Created by PCQ196 on 09/02/21.
//

import UIKit
import CoreData

class CategoryListViewController: UIViewController {

    @IBOutlet weak var tblCategory: UITableView!
    
    var categories : [Category]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCategory.register(UINib(nibName: "CategoryTblCell", bundle: .main), forCellReuseIdentifier: "CategoryTblCell")
        fetchData()
    }

    // to fetch data from coredata
    func fetchData(){
            
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            
            categories = try managedContext.fetch(Category.fetchRequest())
            tblCategory.reloadData()
            
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
       
    }
    
    // to save data in Coredata
    func saveData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let category = Category(context: managedContext)
        category.name = "Hello"
                
        try! managedContext.save()
    }
}

// MARK: - Table view configurations
extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTblCell", for: indexPath) as! CategoryTblCell
        cell.lblName.text = categories?[indexPath.row].name
        return cell
    }
    
    
}
