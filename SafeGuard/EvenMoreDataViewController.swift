//
//  EvenMoreDataViewController.swift
//  SafeGuard
//
//  Created by Student on 3/28/17.
//  Copyright © 2017 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit

class EvenMoreDataViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
var meme: passwordClassword?
    override func viewDidLoad() {
        name.text = meme?.title
        desc.text = meme?.content
           }

   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
