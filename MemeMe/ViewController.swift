//
//  ViewController.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/8/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topOutline: UITextField!
    @IBOutlet weak var bottomOutline: UITextField!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var albumBtn: UIBarButtonItem!
    @IBOutlet weak var actionBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    struct Meme{
        let topText:String
        let bottomText:String
        let originalImage:UIImage
        let memeImage:UIImage
    }
    let memeTextAttributes:[NSAttributedString.Key:Any]=[
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue):UIColor.black,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):UIColor.white,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue):2.5,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        topOutline.delegate=self
        bottomOutline.delegate=self
        topOutline.text="TOP"
        bottomOutline.text="BOTTOM"
        topOutline.defaultTextAttributes=memeTextAttributes
        bottomOutline.defaultTextAttributes=memeTextAttributes
        topOutline.textAlignment = .center
        bottomOutline.textAlignment = .center
        actionBtn.isEnabled = !(imageView.image==nil)
        cameraBtn.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeToKeyboardNotifications()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text=""
        if textField==bottomOutline{
            //to avoid shifting the view up when editing the topOutline as it hides it
            subscribeToKeyboardNotifications()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //MARK: Pick image functions
    @IBAction func pickImageAlbum(_ sender: Any) {
        let imagePicker=UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate=self
        present(imagePicker,animated: true,completion: nil)
    }
    
    @IBAction func pickImageCamera(_ sender: Any) {
        let imagePicker=UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate=self
        present(imagePicker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage=info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image=pickedImage
            actionBtn.isEnabled=true
            
        }
        else{
            let alert=UIAlertController(title: "ERROR loading Image", message: "Something wrong happened ,please try again", preferredStyle: .alert)
            let okAction=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
             present(alert,animated: true,completion: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    //MARK: keyboard related functions
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification:Notification){
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    func getKeyboardHeight(_ notification:Notification)->CGFloat{
        let userInfo=notification.userInfo
        let keyboardSize=userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(){
        view.frame.origin.y=0
    }
    //MARK: generate the meme image
    func generateMemeImage()->UIImage?{
        navBar.isHidden=true
        toolBar.isHidden=true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        if let memedImage=UIGraphicsGetImageFromCurrentImageContext(){
            navBar.isHidden=false
            toolBar.isHidden=false
            return memedImage
        }
        else{
            navBar.isHidden=false
            toolBar.isHidden=false
            return nil
        }
    }
    //save function is not used yet
//    func save(){
//        let meme=Meme(topText: topOutline.text!, bottomText: bottomOutline.text!, originalImage: imageView.image!, memeImage: generateMemeImage()!)
//    }

    @IBAction func share(_ sender: Any) {
        if let memedImage=generateMemeImage(){
            let activityVC=UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
              present(activityVC,animated: true,completion: nil)
            //activity view controller is dismissed automatically
        }
        else{
            let alert=UIAlertController(title: "Error generating meme image", message: "please try again", preferredStyle: .alert)
            let okAction=UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert,animated: true,completion: nil)
        }
      
    }
    
    @IBAction func cancel(_ sender: Any) {
        imageView.image=nil
        topOutline.text="TOP"
        bottomOutline.text="BOTTOM"
        actionBtn.isEnabled=false
    }
    
    
    
}

