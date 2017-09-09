//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Sanket Ray on 07/09/17.
//  Copyright © 2017 Sanket Ray. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        detailImage.image = appDelegate.selectedMeme?.memedImage
        
    }

    @IBOutlet weak var detailImage: UIImageView!


}
