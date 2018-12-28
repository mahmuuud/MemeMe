//
//  TableViewVC.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/28/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import UIKit

class TableViewVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var memes:[Meme]!{
        let object=UIApplication.shared.delegate
        let delegate=object as! AppDelegate
        return delegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")
        let meme=self.memes[indexPath.row]
        cell?.textLabel?.text=meme.topText
        cell?.detailTextLabel?.text=meme.bottomText
        cell?.imageView?.image=meme.originalImage
        return cell!
    }
   
}
