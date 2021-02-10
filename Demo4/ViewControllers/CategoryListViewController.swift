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
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
        //deleteAllData()
    }
    
    @objc func addCategory(){
        self.presentAlertWithTF()
    }

    // to fetch data from coredata
    func fetchData(){
        
        do {
            
            categories = try managedContext.fetch(Category.fetchRequest())
            tblCategory.reloadData()
            
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
       
    }
    
    // to save data in Coredata
    func saveData(){

        do{
            try managedContext.save()
        } catch{
            print("Error in save context\(error)")
        }
        
    }
    
    // to delete all data from coredata
    func deleteAllData(){
            
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
            do {
                let items = try managedContext.fetch(Category.fetchRequest()) as! [NSManagedObject]
                for item in items {
                    managedContext.delete(item)
                }
                try managedContext.save()
                
            } catch {
                print("Error in deleting...")
            }
    }
    
    // to configure alertview with text fields
    func presentAlertWithTF(){
        
        alertWithTF = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let add = UIAlertAction(title: "Add", style: .default) { (_ action) in
            
            let txtName = self.alertWithTF!.textFields![0] as UITextField
            
            if !Util.isStringNull(srcString: txtName.text!){
                
                let category = Category(context: self.managedContext)
                category.name = txtName.text!
                self.categories?.append(category)
                self.saveData()
                DispatchQueue.main.async {
                    self.tblCategory.reloadData()
                }
            }
        }
        
        alertWithTF!.addTextField { (textField) in
            textField.placeholder = "Enter category name..."
        }
       
        alertWithTF!.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alertWithTF!.addAction(add)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = Util.getStoryboard().instantiateViewController(withIdentifier: "NotesListViewController") as! NotesListViewController
        vc.selectedCategory = self.categories?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

