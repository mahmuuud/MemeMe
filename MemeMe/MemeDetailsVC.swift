//
//  MemeDetailsVC.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/30/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import UIKit

class MemeDetailsVC: UIViewController {
    var image:UIImage!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image=image
    }
    

}
