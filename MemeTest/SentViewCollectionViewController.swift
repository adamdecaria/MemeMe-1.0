//
//  SentViewCollectionViewController.swift
//  MemeMe 1.0
//
//  Created by Adam DeCaria on 2016-10-16.
//  Copyright © 2016 Adam DeCaria. All rights reserved.
//

import Foundation
import UIKit

class SentViewCollectionViewController: UICollectionViewController {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return memes.count
       
    } // End collectionView
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for: indexPath) as! SentMemesCollectionViewCell
        let meme = memes[indexPath.item]
        let image = meme.memedImage
        cell.savedMemeImageView.image = image
        
        return cell
        
    }
 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let object: AnyObject = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController")
        let memeView = object as! MemeViewController
        
        memeView.chosenImage = UIImageView(image: self.memes[indexPath.row].memedImage)

        navigationController!.pushViewController(memeView, animated: true)
    }
        
    
    
} // End SentViewCollectionViewController
