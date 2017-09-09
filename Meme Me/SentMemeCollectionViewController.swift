//
//  SentMemeCollectionViewController.swift
//  Meme Me
//
//  Created by Sanket Ray on 07/09/17.
//  Copyright © 2017 Sanket Ray. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var memes : [Meme]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.image.image = meme.memedImage

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.selectedMeme = meme
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "detailView") as! MemeDetailViewController
        
        navigationController?.pushViewController(controller, animated: true)
    }
    


}
