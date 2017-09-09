//
//  MemeEditorViewController.swift
//  Meme Me
//
//  Created by Sanket Ray on 01/05/17.
//  Copyright © 2017 Sanket Ray. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var Camera: UIBarButtonItem!
    @IBOutlet weak var topToolBar: UINavigationBar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        top.text = "TOP"
        bottom.text = "BOTTOM"
        configureTextField(textField: top)
        configureTextField(textField: bottom)
        
        Share.isEnabled = false
        

    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureTextField(textField: UITextField){
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    
    func keyboardWillShow(_ notification:Notification) {
        if bottom.isEditing {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
       
    }
 
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

    }
 

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        top.resignFirstResponder()
        bottom.resignFirstResponder()
        return true
    }
    
    let memeTextAttributes: [String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let Image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image = Image
        }
        
        Share.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }


    
    func save() {
        // Create the meme
        let meme = Meme(topText: top.text!, bottomText: bottom.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
       
    }
    
    func generateMemedImage() -> UIImage {
        
        toolBar(bool: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar(bool: false)
        
        return memedImage
    }
    
    func toolBar(bool : Bool){
        topToolBar.isHidden = bool
        bottomToolBar.isHidden = bool
    }
    
    func configureImage (image : UIImagePickerController, sourceType: UIImagePickerControllerSourceType) {
        image.delegate = self
        self.present(image, animated: true, completion: nil)
        image.sourceType = sourceType
        
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        configureImage(image: imagePicker, sourceType: .photoLibrary)
    }
 

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        configureImage(image: imagePicker, sourceType: .camera)
    }


    
    @IBOutlet weak var Share: UIBarButtonItem!
    
    @IBAction func ShareButtonWasPressed(_ sender: Any) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = {activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}

