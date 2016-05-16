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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        bannerView = ADBannerView(adType: .Banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.hidden = true
        view.addSubview(bannerView)
        
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        do {
            let realm = try Realm()
            passwords = realm.objects(passwordClassword).sorted("modificationDate", ascending: false)
        } catch {
            print("handle error")
        }
    }
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier)")
        }
        
        if let identifier = segue.identifier {
            do {
                let realm = try Realm()
                
                switch identifier {
                case "Save":
                    // 1
                    let source = segue.sourceViewController as! NewNoteViewController
                    try realm.write() {
                        realm.add(source.meme!)
                    }
                    
                case "Delete":
                   try realm.write() {
                        realm.delete(self.passwords!)
                    }
                    
                    let source = segue.sourceViewController as! NoteDisplayViewController
                    source.meme = nil;
                default:
                print("No one loves \(identifier)")
                }
                
                passwords = realm.objects(passwordClassword).sorted("modificationDate", ascending: false)
            } catch {
                print("handle error")
            }
        }    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowExistingNote") {
            let dvc = segue.destinationViewController as! NoteDisplayViewController
            dvc.meme = self.meme
        }
    }
}
extension PassTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PassCell", forIndexPath: indexPath) as! PassTableViewCell //1
        let row = indexPath.row
        let passs = passwords[row] as passwordClassword
        cell.meme = passs

        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords?.count ?? 0
    }
        // 3
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let note = passwords[indexPath.row] as Object
            
            do {
                let realm = try Realm()
                try realm.write() {
                    realm.delete(note)
                }
                
                passwords = realm.objects(passwordClassword).sorted("modificationDate", ascending: false)
            } catch {
                print("handle error")
            }
        }
    }
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        bannerView.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        bannerView.hidden = true
    }
}
    
