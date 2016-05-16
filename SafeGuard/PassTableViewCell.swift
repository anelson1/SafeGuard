import UIKit
import RealmSwift
import Foundation


class PassTableViewCell: UITableViewCell {
    
    // initialize the date formatter only once, using a static computed property
    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var meme: passwordClassword? {
        didSet {
            if let meme = meme, titleLabel = titleLabel, dateLabel = dateLabel {
                titleLabel.text = meme.title
                dateLabel.text = meme.content
            }
        }
    }
    
}