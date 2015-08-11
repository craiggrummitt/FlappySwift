//
//  GameViewController.swift
//  FlappySwift
//
//  Created by Craig on 7/08/2015.
//  Copyright (c) 2015 InteractiveCoconut. All rights reserved.
//

import UIKit
import SpriteKit
import ActionSwift3

class GameViewController: UIViewController {
    var flappyBird:FlappyBird?
    override func viewDidLoad() {
        super.viewDidLoad()
        let stage = Stage(self.view as! SKView)
        flappyBird = FlappyBird()
        stage.addChild(flappyBird!)
        flappyBird!.setUpTitleScreen()
        
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
