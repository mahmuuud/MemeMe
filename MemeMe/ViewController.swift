//
//  ViewController.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/8/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topOutline: UITextField!
    @IBOutlet weak var bottomOutline: UITextField!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var albumBtn: UIBarButtonItem!
    @IBOutlet weak var actionBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text=""
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
        }
        dismiss(animated: true, completion: nil)
    }
    


}

