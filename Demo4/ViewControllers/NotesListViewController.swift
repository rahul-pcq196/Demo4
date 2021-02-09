//
//  NotesListViewController.swift
//  Demo4
//
//  Created by PCQ196 on 09/02/21.
//

import UIKit
import CoreData

class NotesListViewController: UIViewController {
    
    @IBOutlet weak var tblNotes: UITableView!

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notes: [Notes]? = []
    var selectedCategory: Category?{
        didSet{
            self.fetchData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedCategory?.name
        
        // register tableview cell
        tblNotes.register(UINib(nibName: "NoteTblCell", bundle: .main), forCellReuseIdentifier: "NoteTblCell")
        
        // set Add button in navigation bar
        let addBarButtonItem = UIBarButtonItem(image: UIImage.add, style: .done, target: self, action: #selector(self.addNote))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc func addNote(){
        print("Add note")
    }
    
    // to fetch data from Coredata
    func fetchData(){
        
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory?.name ?? "")
        
        do {
            try notes = managedContext.fetch(request)
        }catch {
            print("Error")
        }
    }
    
}

// MARK: - Tableview configurations
extension NotesListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTblCell", for: indexPath) as! NoteTblCell
        cell.lblTitle.text = notes?[indexPath.row].title
        return cell
    }
    
    
}







































