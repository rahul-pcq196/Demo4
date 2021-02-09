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
    
    var alertWithTF : UIAlertController?
    var categories : [Category]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // register tableview cell
        tblCategory.register(UINib(nibName: "CategoryTblCell", bundle: .main), forCellReuseIdentifier: "CategoryTblCell")
        
        // set Add button in navigation bar
        let addBarButtonItem = UIBarButtonItem(image: UIImage.add, style: .done, target: self, action: #selector(self.addCategory))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    @objc func addCategory(){
        self.presentAlertWithTF()
        
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
    func saveData(catName: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let category = Category(context: managedContext)
        category.name = catName
        
        categories?.append(category)
                
        try! managedContext.save()
    }
    
    // to configure alertview with text fields
    func presentAlertWithTF(){
        
        alertWithTF = UIAlertController(title: "Enter Category name", message: "", preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Add", style: .default) { (_ action) in
            
            let txtName = self.alertWithTF!.textFields![0] as UITextField
            
            if !Util.isStringNull(srcString: txtName.text!){
                self.saveData(catName: txtName.text!)
                self.tblCategory.reloadData()
            }
            
        }
        
        alertWithTF!.addTextField { (textField) in
            textField.placeholder = "Name"
        }
       
        alertWithTF!.addAction(add)
        alertWithTF!.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alertWithTF!, animated: true, completion: nil)
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

