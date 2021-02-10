//
//  EditNoteViewController.swift
//  Demo4
//
//  Created by PCQ196 on 09/02/21.
//

import UIKit
import CoreData

class EditNoteViewController: UIViewController {

    @IBOutlet weak var txtvwNote: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory: Category?
    var selectedNoteId: Int16?
    var isEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ui modifications
        btnSave.layer.cornerRadius = 10
        txtvwNote.layer.cornerRadius = 10
        
        if isEdit{
            setNote()
            btnDelete.isUserInteractionEnabled = true
            btnDelete.alpha = 1
        } else {
            btnDelete.isUserInteractionEnabled = false
            btnDelete.alpha = 0.5
        }
    }
    
    @IBAction func userHandle(_ sender: UIButton){
        
        if sender == btnSave{
            
            if isEdit{
                self.saveExsitingNote()
            } else {
                self.saveNewNote()
            }
            self.navigationController?.popViewController(animated: true)
            
        } else if sender == btnDelete{
            
            let deleteAct = UIAlertAction(title: "Delete", style: .destructive) { (_ action) in
                self.deleteNote()
                self.navigationController?.popViewController(animated: true)
            }
            let cancelAct = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            Alert.shared.ShowAlert(title: "Are you sure you want to delete this note ?", message: "", in: self, withAction: [cancelAct, deleteAct], addCloseAction: false)
            
        }
    }
    
    // to set note title of selected note in textview
    func setNote(){
        
        let fetchNote: NSFetchRequest<Notes> = Notes.fetchRequest()
        fetchNote.predicate = NSPredicate(format: "id = %@", "\(self.selectedNoteId ?? 0)")
        let results = try? managedContext.fetch(fetchNote)
        
        if results?.count != 0{
            
            let note = results?.first
            self.txtvwNote.text = note?.title
        }
        
    }
    
    // to update existing note
    func saveExsitingNote(){
        
        let fetchNote: NSFetchRequest<Notes> = Notes.fetchRequest()
        fetchNote.predicate = NSPredicate(format: "id = %@", "\(self.selectedNoteId ?? 0)")
        let results = try? managedContext.fetch(fetchNote)
        
        if results?.count != 0 && !Util.isStringNull(srcString: self.txtvwNote.text){
            
            let note = results?.first
            note?.title = self.txtvwNote.text
            self.saveData()
        }
        
    }
    
    // to save new note
    func saveNewNote(){
        
        let note = Notes(context: managedContext)
        note.title = self.txtvwNote.text
        note.id = Int16.random(in: 0..<1000)
        note.parentCategory = self.selectedCategory
        
        self.saveData()
        
    }
    
    // to delete current note
    func deleteNote(){
       
        let fetchNote: NSFetchRequest<Notes> = Notes.fetchRequest()
        fetchNote.predicate = NSPredicate(format: "id = %@", "\(self.selectedNoteId ?? 0)")
        let results = try? managedContext.fetch(fetchNote)
        
        if results?.count != 0 && !Util.isStringNull(srcString: self.txtvwNote.text){
            
            let note = results?.first
            managedContext.delete(note!)
            self.saveData()
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

}
