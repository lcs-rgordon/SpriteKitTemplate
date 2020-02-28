//
//  ViewController.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change size of view
        // Students:
        //
        //      Choose Product > Clean Build Folder
        //
        // ... to be sure Xcode picks up the window size change, if you change it.
        self.skView.frame = NSRect(x: 0, y: 0, width: 800, height: 600)

        // Create a scene based on the GameScene class (in GameScene.swift)
        // Scene size is a bit smaller but will scale up to fill the window
        let sceneSize = CGSize(width: 800, height: 600)
        let scene = GameScene(size: sceneSize)
        scene.scaleMode = .aspectFill
        
        // Show frames per second in the view
        self.skView.showsFPS = true
        
        // Keep track of how many nodes (visual elements) are on screen
        // (The fewer nodes the better for performance reasons)
        self.skView.showsNodeCount = true
        
        // Show the outlines of physics bodies
        self.skView.showsPhysics = true
        
        // Present the scene (which is an instance of the GameScene class)
        skView.presentScene(scene)

    }
}

