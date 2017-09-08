//
//  SentMemeViewController.swift
//  Meme Me
//
//  Created by Sanket Ray on 17/05/17.
//  Copyright © 2017 Sanket Ray. All rights reserved.
//

import UIKit

 
class SentMemeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var memes : [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellID = "MemeTable"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        
        let match = self.memes[(indexPath as NSIndexPath).row]
        
    
        
        return cell
    }
    
    
 
}
