//
//  MemesCollectionVC.swift
//  MemeMe
//
//  Created by mahmoud mohamed on 12/28/18.
//  Copyright © 2018 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit

class MemesCollectionVC:UICollectionViewController{
    var memes:[Meme]!{
        let object = UIApplication.shared.delegate
        let delegate = object as! AppDelegate
        return delegate.memes
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
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
        let memeEditVC=storyboard?.instantiateViewController(withIdentifier: "MemeEditor") as! MemeEditorVC
        let meme=memes[indexPath.row]
        memeEditVC.topOutline.text=meme.topText
        memeEditVC.bottomOutline.text=meme.bottomText
        memeEditVC.imageView.image=meme.originalImage
        self.navigationController!.pushViewController(memeEditVC, animated: true)
        
    }
}
