import UIKit
import iAd

class NewNoteViewController: UIViewController,ADBannerViewDelegate {
    var meme: passwordClassword?
    var bannerView: ADBannerView!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = ADBannerView(adType: .banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.isHidden = true
        view.addSubview(bannerView)
        
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowNewNote") {
            meme = passwordClassword()
            let dvc = segue.destination as! NoteDisplayViewController
            dvc.meme = meme
        }
    }
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        bannerView.isHidden = false
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        bannerView.isHidden = true
    }
    }
