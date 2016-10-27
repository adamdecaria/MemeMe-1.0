//
//  ShowSelectedMemeViewController.swift
//  MemeMe 1.0
//
//  Created by Adam DeCaria on 2016-10-26.
//  Copyright © 2016 Adam DeCaria. All rights reserved.
//

import Foundation
import UIKit

class ShowSelectedMemeViewController: UIViewController {
    
    @IBOutlet weak var selectedMeme: UIImageView!
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedMeme.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
