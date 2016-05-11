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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        displayNote(meme)
    }
    
    //MARK: Business Logic
    
    func displayNote(note: passwordClassword?) {
        if let note = meme, titleTextField = titleTextField, contentTextView = contentTextField  {
            titleTextField.text = note.title
            contentTextView.text = note.content
        }
    }
    


override func viewWillDisappear(animated: Bool) {
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
                        note.modificationDate = NSDate()
                    }
                }
                
            } catch {
                print("handle error")
            }
        }
    }
    
}