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
        
        cell?.imageView?.image = memeImage.memedImage
        cell?.textLabel?.text = memeImage.topText + " ... " + memeImage.bottomText
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let memeView = self.storyboard!.instantiateViewController(withIdentifier: "ShowSelectedMemeViewController") as! ShowSelectedMemeViewController
        memeView.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(memeView, animated: true)
    }
    
}
