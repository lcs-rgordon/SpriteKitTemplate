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
    
    // A deck of cards
    var deck = Deck()
    
    // A hand of cards
    var player = Hand(description: "player")
    
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {
        
        // Set the background colour to a dark green (HSB)
        // See: http://colorizer.org to find color values
        self.backgroundColor = NSColor(hue: 102/360, saturation: 86/100, brightness: 24/100, alpha: 1)
        
        // Get a reference to the mp3 file in the app bundle
        let backgroundMusicFilePath = Bundle.main.path(forResource: "background.wav", ofType: nil)!
        
        // Convert the file path string to a URL (Uniform Resource Locator)
        let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)
        
        // Attempt to open and play the file at the given URL
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
            //backgroundMusic?.play()
        } catch {
            // Do nothing if the sound file could not be played
        }
                            
    }
        
    func touchDown(atPoint pos : CGPoint) {
        newHand(faceUp: false)
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
        case 49:
            newHand(faceUp: true)
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // Deal a new hand
    func newHand(faceUp: Bool) {
        
        // Remove all nodes
        self.removeAllChildren()
        
        // Make a new deck
        deck = Deck()
        
        // Make a hand
        player = Hand(description: "player")
        
        // Deal to the player
        if let newCards = self.deck.randomlyDealOut(thisManyCards: 26) {
            player.cards = newCards
        }
        
        // Make a visual hand of cards
        let playerVisualHand = SKHand(cards: player.cards)
        
        // Display the cards in this scene
        playerVisualHand.display(anchor: CGPoint(x: playerVisualHand.visualCards[0].node.size.width / 2, y: self.size.height / 2), spacing: 25, faceUp: faceUp, on: self)

    }

}
