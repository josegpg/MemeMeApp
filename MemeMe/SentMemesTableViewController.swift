//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Jose Piñero on 12/26/15.
//  Copyright © 2015 José Piñero. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell", forIndexPath: indexPath) as! MemeTableViewCell
        cell.setUp(memes[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func createMeme(sender: UIBarButtonItem) {
        let editor = storyboard?.instantiateViewControllerWithIdentifier("EditorViewController") as! EditViewController
        presentViewController(editor, animated: true, completion: nil)
    }
}