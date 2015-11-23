//
//  EditViewController.swift
//  MemeMe
//
//  Created by Jose Piñero on 11/22/15.
//  Copyright © 2015 José Piñero. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let initialTexts = ["TOP", "BOTTOM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up initial interface
        clearAll()
    }
    
    override func viewWillAppear(animated: Bool) {
        // Disable the camera button if the device doesn't support it
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        // Get notified when keyboard appears
        subscribeToKeyboardNotifications()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setUpTextField(textField: UITextField, withText text: String) {
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
        textField.delegate = self
        textField.text = text
    }
    
    override func viewWillDisappear(animated: Bool) {
        // Stop receiving notifications
        unsubscribeFromKeyboardNotifications()
    }
    
    func save() {
        let _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: pickedImage.image!, memedImage: getMemedImage())
    }
    
    func getMemedImage() -> UIImage {
        // Hide tool bars
        toolBarsShouldShow(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        // Show tool bars again
        toolBarsShouldShow(false)
        
        return memedImage
    }
    
    func toolBarsShouldShow(hidden: Bool) {
        topToolbar.hidden = hidden
        bottomToolbar.hidden = hidden
    }
    
    func clearAll() {
        // Clear images
        pickedImage.image = nil
        
        // Set the attributes to the textfields
        setUpTextField(topTextField, withText: "TOP")
        setUpTextField(bottomTextField, withText: "BOTTOM")
        
        // Disable share button
        shareButton.enabled = false
    }
    
    //MARK: - Notifications
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        // We should move the view if the textField to edit is the bottom one
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //MARK: - Actions

    @IBAction func pickFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        // Set the source of the image as the camera
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func pickFromAlbum(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        // Set the source of the image as the photo albums
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        
        let activityVC = UIActivityViewController(activityItems: [getMemedImage()], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                self.save()
            }
        }
        
        presentViewController(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelEdit(sender: UIBarButtonItem) {
        clearAll()
    }
}

extension EditViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // Cleans the textfield if it conains an initial text
        if initialTexts.contains(textField.text!) {
            textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide keyboard
        textField.resignFirstResponder()
        
        return true
    }
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Retrieve the picked image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickedImage.image = image
            shareButton.enabled = true // Meme is complete
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Only dismiss the view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}