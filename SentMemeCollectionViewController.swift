//
//  SentMemeCollectionViewController.swift
//  MemeMe 1.0
//
//  Created by Adam DeCaria on 2016-10-20.
//  Copyright © 2016 Adam DeCaria. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
    
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
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.savedMemeImageView.image = meme.memedImage
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memeView = self.storyboard!.instantiateViewController(withIdentifier: "ShowSelectedMemeViewController") as! ShowSelectedMemeViewController
        memeView.meme = self.memes[indexPath.item]
        self.navigationController?.pushViewController(memeView, animated: true)
               
    }
    
    
    
} // End SentViewCollectionViewController
