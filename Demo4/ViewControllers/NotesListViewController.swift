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
    @IBOutlet weak var txtsearch: UISearchBar!

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notes: [Notes]? = []
    var arrFilteredNotes: [Notes]? = []
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedCategory?.name
        
        // register tableview cell
        tblNotes.register(UINib(nibName: K.noteTblCellNibName, bundle: .main), forCellReuseIdentifier: K.noteTblCellIdentifire)
        
        // set Add button in navigation bar
        let addBarButtonItem = UIBarButtonItem(image: UIImage.add, style: .done, target: self, action: #selector(self.addNote))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchData()
    }
    
    @objc func addNote(){
        
        let vc = Util.getStoryboard().instantiateViewController(withIdentifier: K.editNoteViewControllerId) as! EditNoteViewController
        vc.selectedCategory = self.selectedCategory
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // to fetch data from Coredata
    func fetchData(){
        
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory?.name ?? "")
        
        do {
            try notes = managedContext.fetch(request)
            arrFilteredNotes = notes
            self.tblNotes.reloadData()
        }catch {
            print("Error")
        }
        
    }
    
}

// MARK: - Tableview configurations
extension NotesListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilteredNotes!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.noteTblCellIdentifire, for: indexPath) as! NoteTblCell
        cell.lblTitle.text = arrFilteredNotes?[indexPath.row].title
        cell.noteId = arrFilteredNotes?[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! NoteTblCell
        let vc = Util.getStoryboard().instantiateViewController(withIdentifier: K.editNoteViewControllerId) as! EditNoteViewController
        vc.selectedNoteId = selectedCell.noteId
        vc.isEdit = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Searchbar delegate functions
extension NotesListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if Util.isStringNull(srcString: searchText){
            arrFilteredNotes = notes
        } else {
            let searchPredicate = NSPredicate(format: "title CONTAINS[C] %@", searchText)
            arrFilteredNotes = (notes! as NSArray).filtered(using: searchPredicate) as? [Notes]

        }
        tblNotes.reloadData()
        
    }
}





































