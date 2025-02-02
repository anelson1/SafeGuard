import UIKit
class DetailViewController: UIViewController {

    @IBOutlet weak var passwordTitle: UILabel!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var passwordTextField: UITextView!
    
    
    var data = ClassOfData()
    var passwords = password()
    var dataArray = [String]()
    let savedPassword = UserDefaults.standard
   
        override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
            
            if var anothersavedPassword = savedPassword.string(forKey: "RealPassword"){
anothersavedPassword = data.password            }
        passwordTextField.text = data.password
            passwordTitle.text = data.title
            
    }
    @IBAction func onScreenTapped(_ sender: AnyObject) {
        passwordTextField.resignFirstResponder()
    }
    @IBAction func saveButton(_ sender: AnyObject) {
        data.password = passwordTextField.text
        savedPassword.setValue(data.password, forKey: "RealPassword")
        savedPassword.synchronize()

        
        
    
    }
    
}

