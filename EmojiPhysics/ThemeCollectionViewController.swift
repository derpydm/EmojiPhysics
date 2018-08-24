//
//  ThemeCollectionViewController.swift
//  EmojiPhysics
//
//  Created by Sean on 4/8/18.
//  Copyright © 2018 Sean. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ThemeCollectionViewController: UICollectionViewController {
    let currentEmojis = [EmojiTheme(title: "Classic", emojis:["😂","🐒","👩🏼‍🎓","👦🏻","😱","😅","💩"]), EmojiTheme(title: "Modern", emojis:["😂","🐒","💩"]), EmojiTheme(title: "Another", emojis:["😂","🐒","🐧"])]
    var currentSelectedCell: ThemeCollectionViewCell!
    var currentSelectedIndexPath: IndexPath!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "updateSegue" {
            let dest = segue.destination as! EmojiViewController
            dest.currentEmojis = currentEmojis[currentSelectedIndexPath.item].emojis
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return currentEmojis.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ThemeCollectionViewCell
        cell.titleLabel.text = currentEmojis[indexPath.item].title
        let emojiText = String(currentEmojis[indexPath.item].emojis)
        cell.detailLabel.text = emojiText
        cell.outlineView.layer.shadowColor = UIColor.black.cgColor
        cell.outlineView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.outlineView.layer.shadowOpacity = 0.5
        cell.outlineView.layer.shadowRadius = 8
        cell.outlineView.layer.cornerRadius = 20
        if indexPath.row == selectedEmoji {
            currentSelectedIndexPath = indexPath
            cell.outlineView.backgroundColor = UIColor(red: 1, green: 0.82, blue: 0.988, alpha: 1)
        }
        // Configure the cell
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 10, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ThemeCollectionViewCell
        cell.outlineView.backgroundColor = UIColor(red: 1, green: 0.82, blue: 0.988, alpha: 1)
        currentSelectedCell = collectionView.cellForItem(at: currentSelectedIndexPath) as! ThemeCollectionViewCell
        currentSelectedCell.outlineView.backgroundColor = UIColor(red: 0.82, green: 1, blue: 0.922, alpha: 1)
        currentSelectedIndexPath = indexPath
        selectedEmoji = indexPath.row
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
