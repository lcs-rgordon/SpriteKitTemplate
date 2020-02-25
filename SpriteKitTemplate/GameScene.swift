//
//  GameScene.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    // Background music player
    var backgroundMusic: AVAudioPlayer?
    
    // Height of a player
    let playerHeight: CGFloat = 100
    
    // Player nodes
    var leftPlayer: SKShapeNode = SKShapeNode()
    
    // Track intervals between frame updates
    // See https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html
    // ... for game loop illustration
    // We cannot count on update(_:) being called with a consistent elapsed time between frame draws.
    // So we track how much time has elapsed since the last update, so that movement appears smooth
    var lastUpdateTime: TimeInterval = 0    // The time at which the last update occured
    var deltaTime: TimeInterval = 0         // Change in time since last update
    
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {
        
        // Set the background colour to a dark green (HSB)
        // See: http://colorizer.org to find color values
        self.backgroundColor = NSColor.black
        
        // No background music to start
        backgroundMusic = nil
        
        // Add the left-hand player
        leftPlayer = SKShapeNode(rect: CGRect(x: 50, y: self.size.height / 2 - playerHeight / 2, width: 25, height: 100))
        leftPlayer.fillColor = NSColor.white
        self.addChild(leftPlayer)
            
    }
        
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    // Responds when a key is down
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
                
        if lastUpdateTime > 0 {
            // Update to reflect time elapsed since the last call to update(_:)
            deltaTime = currentTime - lastUpdateTime
        }
        // Log the time of this most recent time update
        lastUpdateTime = currentTime
        print("\(deltaTime * 1000) milliseconds since last update")
        
    }
    
    func playBackgroundMusic() {
        
        // Get a reference to the mp3 file in the app bundle
        let backgroundMusicFilePath = Bundle.main.path(forResource: "background.wav", ofType: nil)!
        
        // Convert the file path string to a URL (Uniform Resource Locator)
        let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)
        
        // Attempt to open and play the file at the given URL
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
            backgroundMusic?.play()
        } catch {
            // Do nothing if the sound file could not be played
        }

    }

}
