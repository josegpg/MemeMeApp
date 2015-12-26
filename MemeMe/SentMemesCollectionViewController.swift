//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Jose Piñero on 12/26/15.
//  Copyright © 2015 José Piñero. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        cell.setUp(memes[indexPath.row])
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func createMeme(sender: UIBarButtonItem) {
        let editor = storyboard?.instantiateViewControllerWithIdentifier("EditorViewController") as! EditViewController
        presentViewController(editor, animated: true, completion: nil)
    }
}
