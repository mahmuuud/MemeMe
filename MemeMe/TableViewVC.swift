//
//  TableViewVC.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/28/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import UIKit

class TableViewVC: UITableViewController {
    var memes:[Meme]!{
        let object=UIApplication.shared.delegate
        let delegate=object as! AppDelegate
        return delegate.memes
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")
        let meme=self.memes[indexPath.row]
        cell?.textLabel?.text=meme.topText+"..."+meme.bottomText
        cell?.imageView?.image=meme.originalImage
        return cell!
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailsVC=self.storyboard?.instantiateViewController(withIdentifier: "memeDetails") as! MemeDetailsVC
        memeDetailsVC.image=self.memes[indexPath.row].memeImage
        self.navigationController!.pushViewController(memeDetailsVC, animated: true)
    }
    
}
