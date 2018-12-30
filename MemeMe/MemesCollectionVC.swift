//
//  MemesCollectionVC.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/28/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit

class MemesCollectionVC:UICollectionViewController,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes:[Meme]!{
        let object = UIApplication.shared.delegate
        let delegate = object as! AppDelegate
        return delegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat=3.0
        let size=self.view.frame.size
        configureFlowLayout(space: space, size: size.width)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let memes=self.memes{
            return memes.count
        }
        else{
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme=self.memes[indexPath.row]
        cell.topLabel.text=meme.topText
        cell.bottomLabel.text=meme.bottomText
        cell.imageView.image=meme.originalImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath){
        let memeDetailsVC=self.storyboard?.instantiateViewController(withIdentifier: "memeDetails") as! MemeDetailsVC
        memeDetailsVC.image=self.memes[indexPath.row].memeImage
        self.navigationController!.pushViewController(memeDetailsVC, animated: true)
        
    }
    
    func configureFlowLayout(space:CGFloat,size:CGFloat){
        flowLayout.minimumInteritemSpacing=space
        flowLayout.minimumLineSpacing=space
        let dimension=(size - (2 * space)) / 3.0
        flowLayout.itemSize=CGSize(width: dimension, height: dimension)
    }
    
}
