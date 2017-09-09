//
//  SentMemeTableViewController.swift
//  Meme Me
//
//  Created by Sanket Ray on 17/05/17.
//  Copyright © 2017 Sanket Ray. All rights reserved.
//

import UIKit

 
class SentMemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var memes : [Meme]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
        
        let meme = memes[indexPath.row]
        cell.tableViewImage.image = meme.memedImage
        cell.label.text = "\(meme.topText) \(meme.bottomText)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let meme = memes[indexPath.row]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.selectedMeme = meme
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "detailView") as! MemeDetailViewController
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
 
}
