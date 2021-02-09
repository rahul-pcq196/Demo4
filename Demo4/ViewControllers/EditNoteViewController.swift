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
        }
        
    }
    
    @IBAction func userHandle(_ sender: UIButton){
        
        if sender == btnSave{
            self.saveNote()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setNote(){
        
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        request.predicate = NSPredicate(format: "id MATCHES %@", selectedNoteId ?? 0)
        
        do {
            let note = try managedContext.fetch(request)
            self.txtvwNote.text = note[0].title
        }catch {
            print("Error")
        }
    }
    
    func saveNote(){
        
        let note = Notes(context: managedContext)
        note.title = self.txtvwNote.text
        note.id = Int16.random(in: 0..<1000)
        note.parentCategory = self.selectedCategory
        
        self.saveData()
        
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
