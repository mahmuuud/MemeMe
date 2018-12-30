//
//  TextAttributes.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/30/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit

class TextAttributes{
   static let memeTextAttributes:[NSAttributedString.Key:Any]=[
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue):UIColor.black,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):UIColor.white,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue):-4.0,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]
}
