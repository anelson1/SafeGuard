//
//  pictureScreenViewController.swift
//  SafeGuard
//
//  Created by Student on 4/18/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit

class pictureScreenViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    
    @IBOutlet weak var imageFour: UIImageView!
    
    
let imagePicker = UIImagePickerController()
    var pictureNumber = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }


    
    
    @IBAction func imageChooser(sender: AnyObject) {
        let mySheet = UIAlertController(title: "Please Choose A Picture", message: nil, preferredStyle: .ActionSheet)
        mySheet.addAction(UIAlertAction(title: "Libary Of Photos", style: .Default, handler: { (libraryAction) in
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }))
        
        presentViewController(mySheet, animated: true, completion: nil)

    }
    
        



    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true) { () -> Void in
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            if self.pictureNumber == 0{
            self.imageOne.image = selectedImage
            }
            else if self.pictureNumber == 1{
                self.imageTwo.image = selectedImage
            }
            else if self.pictureNumber == 2{
                self.imageThree.image = selectedImage
            }

            else if self.pictureNumber == 3{
                self.imageFour.image = selectedImage
            }

            else{
                print("spicy eme")
            }
            ++self.pictureNumber
        }

}
}