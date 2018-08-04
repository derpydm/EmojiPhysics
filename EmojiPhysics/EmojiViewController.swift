//
//  ViewController.swift
//  EmojiPhysics
//
//  Created by Sean on 28/7/18.
//  Copyright © 2018 Sean. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "emojiCell"

class EmojiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollisionBehaviorDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gravityLabel: UILabel!
    var emojis = ["😂","🐒","🐧","😥","👩🏻‍⚖️","👨🏿‍🍳","👩🏼‍🎓","👦🏻","😱","😅","💩"]
    var animator: UIDynamicAnimator!
    var collisions: UICollisionBehavior!
    var dynamics: UIDynamicItemBehavior!
    var player: AVQueuePlayer!
    var isPlaying = false
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: mainView)
        collisions = UICollisionBehavior(items: [])
        collisions.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisions)
        collisions.collisionDelegate = self
        
        
        dynamics = UIDynamicItemBehavior(items: [])
        
        dynamics.resistance = 0
        dynamics.elasticity = 1.0
        animator.addBehavior(dynamics)
    
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
        
        dynamics.addItem(label)
        // push randomly
        let push = UIPushBehavior(items: [label], mode: .continuous)
        push.angle = CGFloat(drand48() * .pi * 2) // radians
        push.magnitude = CGFloat(1 + drand48() + drand48()) // between 1 and 3
        animator.addBehavior(push)
        
        // attempted attraction (my romance life irl)\
        let center = CGPoint(x: self.mainView.frame.midX, y: self.mainView.frame.midY)
        let attachment = UIAttachmentBehavior(item: label, attachedToAnchor: center)
        animator.addBehavior(attachment)
        
        // animations.
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            label.transform = CGAffineTransform(scaleX: 3, y: 3)
        }, completion: nil)
        let labelAnimator = UIViewPropertyAnimator(duration: 20, curve: .easeInOut) {
            label.alpha = 0
        }
        labelAnimator.addCompletion { (_) in
            label.removeFromSuperview()
            push.removeItem(label)
            self.dynamics.removeItem(label)
            self.animator.removeBehavior(push)
            self.collisions.removeItem(label)
        }
        labelAnimator.startAnimation()
        
        
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        DispatchQueue.global(qos: .background).async {
            print("oof")
        }
    }
    /* Broken audio implementation
    func playAudio() {
        print("oof")
        let path = Bundle.main.path(forResource: "death", ofType: "mp3")
        if path != nil {
            let audioURL = URL(fileURLWithPath: path!)
            let asset = AVAsset(url: audioURL)
            let playerItem = AVPlayerItem(asset: asset)
            if isPlaying {
                player.insert(playerItem, after: nil)
                player.play()
            } else {
                player = AVQueuePlayer(items: [])
                player.insert(playerItem, after: nil)
                player.play()
                isPlaying = true
            }
            if player.items().count > 5 {
                player.removeAllItems()
                player.insert(playerItem, after: nil)
            }
        }
    }
    */
}

