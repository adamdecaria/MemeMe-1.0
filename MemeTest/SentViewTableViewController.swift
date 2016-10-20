//
//  SentViewTableViewController.swift
//  MemeMe 1.0
//
//  Created by Adam DeCaria on 2016-10-20.
//  Copyright © 2016 Adam DeCaria. All rights reserved.
//

import Foundation
import UIKit

class SentViewTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell")
        let memeImage = memes[indexPath.row]
        
        cell?.textLabel?.text = memeImage.topText
        cell?.imageView?.image = memeImage.memedImage
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object: AnyObject = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController")
        let memeView = object as! MemeViewController
        
        memeView.chosenImage = UIImageView(image: self.memes[indexPath.row].memedImage)
        
        navigationController!.pushViewController(memeView, animated: true)
    }
    
}
