//
//  ViewController.swift
//  EmojiPhysics
//
//  Created by Sean on 28/7/18.
//  Copyright © 2018 Sean. All rights reserved.
//

import UIKit

private let reuseIdentifier = "emojiCell"

class EmojiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    var emojis = ["😂","🐒","🐧","😥","👩🏻‍⚖️","👨🏿‍🍳","👩🏼‍🎓","👦🏻","😱","😅","💩"]
    var animator: UIDynamicAnimator!
    var collisions: UICollisionBehavior!
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: mainView)
        collisions = UICollisionBehavior(items: [])
        collisions.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisions)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmojiCollectionViewCell
        cell.emojiLabel.text = emojis[indexPath.item]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedEmoji = emojis[indexPath.item]
        let labelWidth = 60
        let labelHeight = 60
        let x = CGFloat(drand48() * (Double(mainView.frame.size.width) - Double(labelWidth)))
        let y = CGFloat(drand48() * (Double(mainView.frame.size.height) - Double(labelHeight)))
        let label = UILabel(frame: CGRect(x: x, y: y, width: CGFloat(labelWidth), height: CGFloat(labelHeight)))
        label.text = selectedEmoji
        label.font = label.font.withSize(80)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        mainView.addSubview(label)
        
        collisions.addItem(label)
        
        // push randomly
        let push = UIPushBehavior(items: [label], mode: .instantaneous)
        push.angle = CGFloat(drand48() * .pi * 2) // radians
        push.magnitude = CGFloat(1 + drand48() + drand48()) //between 1 and 3
        animator.addBehavior(push)
        
    }

}

