//
//  StartViewController.swift
//  EmojiPhysics
//
//  Created by Sean on 28/7/18.
//  Copyright © 2018 Sean. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var startLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToStart(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.startLabel.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.startLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.startLabel.transform = CGAffineTransform.identity
        }
        animator.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.startLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }
        animator.startAnimation()
        animator.addCompletion { (_) in
            self.performSegue(withIdentifier: "emojiSegue", sender: Any.self)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
