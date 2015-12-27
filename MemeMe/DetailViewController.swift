//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Jose Piñero on 12/26/15.
//  Copyright © 2015 José Piñero. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var meme: Meme!
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewDidLoad() {
        
        navigationItem.title = "Meme Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editMeme:")
    }
    
    override func viewWillAppear(animated: Bool) {
        memeImage.image = meme.memedImage
    }
    
    func editMeme(sender: UIBarButtonItem) {
        let editor = storyboard?.instantiateViewControllerWithIdentifier("EditorViewController") as! EditViewController
        editor.memeToEdit = meme
        presentViewController(editor, animated: true, completion: nil)
    }
}