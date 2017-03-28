import UIKit
import RealmSwift
import Foundation
import iAd
class PassTableViewController: UITableViewController,ADBannerViewDelegate {
    var passwords: Results<passwordClassword>! {
        didSet {
            // Whenever notes update, update the table view
            tableView?.reloadData()
        }
    }
    var bannerView: ADBannerView!

    var meme: passwordClassword?
    var succ: PassTableViewCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        bannerView = ADBannerView(adType: .banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.isHidden = true
        view.addSubview(bannerView)
        
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            let realm = try Realm()
            passwords = realm.objects(passwordClassword).sorted(byKeyPath: "modificationDate", ascending: false)
        } catch {
            print("handle error")
        }
    }
    @IBAction func unwindToSegue(_ segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier)")
        }
        
        if let identifier = segue.identifier {
            do {
                let realm = try Realm()
                
                switch identifier {
                case "Save":
                    // 1
                    let source = segue.source as! NewNoteViewController
                    try realm.write() {
                        realm.add(source.meme!)
                    }
                    
                case "Delete":
                   try realm.write() {
                        realm.delete(self.passwords!)
                    }
                    
                    let source = segue.source as! NoteDisplayViewController
                    source.meme = nil;
                default:
                print("No one loves \(identifier)")
                }
                
                passwords = realm.objects(passwordClassword).sorted(byKeyPath: "modificationDate", ascending: false)
            } catch {
                print("handle error")
            }
        }    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowExistingNote") {
            let dvc = segue.destination as! NoteDisplayViewController
            dvc.meme = self.meme
        }
        if (segue.identifier == "memes")
        {
            let dvc = segue.destination as! EvenMoreDataViewController
            dvc.meme = meme
        }
    }
}
extension PassTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PassCell", for: indexPath) as! PassTableViewCell //1
        let row = indexPath.row
        let passs = passwords[row] as passwordClassword
        cell.meme = passs

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords?.count ?? 0
    }
        // 3
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 4
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = passwords[indexPath.row] as Object
            
            do {
                let realm = try Realm()
                try realm.write() {
                    realm.delete(note)
                }
                
                passwords = realm.objects(passwordClassword).sorted(byKeyPath: "modificationDate", ascending: false)
            } catch {
                print("handle error")
            }
        }
    }
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        bannerView.isHidden = false
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        bannerView.isHidden = true
    }
    
}
    
