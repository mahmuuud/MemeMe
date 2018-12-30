//
//  MemeEditorVC.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/8/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topOutline: UITextField!
    @IBOutlet weak var bottomOutline: UITextField!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var albumBtn: UIBarButtonItem!
    @IBOutlet weak var actionBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    var topText="TOP"
    var bottomText="BOTTOM"
    var image:UIImage!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextfield(textfield: topOutline, attributes: TextAttributes.memeTextAttributes, withText: topText)
        configureTextfield(textfield: bottomOutline, attributes: TextAttributes.memeTextAttributes, withText: bottomText)
        actionBtn.isEnabled = !(imageView.image==nil)
        cameraBtn.isEnabled=UIImagePickerController.isSourceTypeAvailable(.camera)
        imageView.image=image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    func configureTextfield(textfield: UITextField, attributes: [NSAttributedString.Key: Any], withText: String) {
        textfield.delegate = self
        textfield.defaultTextAttributes = attributes
        textfield.textAlignment = .center
        textfield.text = withText
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text=""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //MARK: Pick image functions
    @IBAction func pickImageAlbum(_ sender: Any) {
        pickImage(sourceType: UIImagePickerController.SourceType.photoLibrary)
    }
    
    @IBAction func pickImageCamera(_ sender: Any) {
       pickImage(sourceType: UIImagePickerController.SourceType.camera)
    }
    
    func pickImage(sourceType:UIImagePickerController.SourceType){
        let imagePicker=UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate=self
        present(imagePicker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage=info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image=pickedImage
            actionBtn.isEnabled=true
            
        }
        else{
            let title="ERROR loading Image"
            let message="Something wrong happened ,please try again"
            alert(title: title, message: message)
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
        if bottomOutline.isFirstResponder{
              view.frame.origin.y = -getKeyboardHeight(notification)
        }
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

    func save(){
        let meme=Meme(topText: topOutline.text!, bottomText: bottomOutline.text!, originalImage: imageView.image!, memeImage: generateMemeImage()!)
        let object=UIApplication.shared.delegate!
        let delegate = object as! AppDelegate
        delegate.memes.append(meme)
    }

    @IBAction func share(_ sender: Any) {
        if let memedImage=generateMemeImage(){
            let activityVC=UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
              present(activityVC,animated: true,completion: nil)
            activityVC.completionWithItemsHandler={
                (activity, completed, items, error) in
                if (completed){
                    self.save()
            }
            //activity view controller is dismissed automatically
        }
        }
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func alert(title:String,message: String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction=UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert,animated: true,completion: nil)
    }
}
