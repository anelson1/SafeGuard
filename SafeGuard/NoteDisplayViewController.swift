import Foundation
import UIKit
import RealmSwift

class NoteDisplayViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextView!
    
    var meme: passwordClassword? {
        didSet {
            displayNote(meme)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        displayNote(meme)
    }
    
    //MARK: Business Logic
    
    func displayNote(_ note: passwordClassword?) {
        if let note = meme, let titleTextField = titleTextField, let contentTextView = contentTextField  {
            titleTextField.text = note.title
            contentTextView.text = note.content
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! PassTableViewController
        dvc.meme = self.meme

    }


override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote()
    }
    
    func saveNote() {
        if let note = meme {
            do {
                let realm = try Realm()
                
                try realm.write {
                    if (note.title != self.titleTextField.text || note.content != self.contentTextField.text) {
                        note.title = self.titleTextField.text!
                        note.content = self.contentTextField.text
                        note.modificationDate = Date()
                    }
                }
                
            } catch {
                print("handle error")
            }
        }
    }
    
}
