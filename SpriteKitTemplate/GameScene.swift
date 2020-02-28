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

class GameElement: SKShapeNode {
    
    // Will control which direction the shape moves in
    var velocity : CGPoint = CGPoint(x: 0, y: 0)
        
}

// Define physics body categories so that we can...
// 1. set what has the ability to collide with what
// 2. find out when different combinations of physics bodies have collided
// See Chapter 9 of 2D Apple Games with Swift
struct PhysicsCategory {
    static let None:    UInt32 = 0
    static let Ball:    UInt32 = 0b1    // 1 in base 10
    static let Player:  UInt32 = 0b10   // 2 in base 10
    static let Edge:    UInt32 = 0b100  // 4 in base 10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Background music player
    var backgroundMusic: AVAudioPlayer?
    
    // Height of a player
    let playerHeight: CGFloat = 100
    
    // Player movement properties
    let playerMovementPerSecond: CGFloat = 150   // 150 points per second

    // Ball movement properties
    let ballMovementPerSecond: CGFloat = 200   // 200 points per second

    // Player nodes
    var playerOne: GameElement = GameElement()
    var playerTwo: GameElement = GameElement()
    
    // Ball node
    var ball = GameElement()

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
        
        // Add the left-hand player (player one)
        playerOne = GameElement(rect: CGRect(x: 0, y: 0, width: 25, height: playerHeight))
        playerOne.position = CGPoint(x: 50, y: self.size.height / 2 - playerOne.frame.height / 2)
        playerOne.fillColor = NSColor.white
        self.addChild(playerOne)
        
        // Add a physics body to the player
        playerOne.physicsBody = SKPhysicsBody(rectangleOf: playerOne.frame.size, center: CGPoint(x: playerOne.frame.size.width / 2, y: playerHeight / 2))
        
        // Set physics body category
        playerOne.physicsBody?.categoryBitMask = PhysicsCategory.Player

        // We handle collisions manually using the contact call back (didBegin) when the player hits the edge
        // In other words, we don't want the physics engine to deal with the collision, we'll take care of it
        playerOne.physicsBody?.collisionBitMask = PhysicsCategory.None

        // Register to get a callback when the player contacts the edge of the scene
        playerOne.physicsBody?.contactTestBitMask = PhysicsCategory.Edge
                
        // Add the right-hand player (player two)
        playerTwo = GameElement(rect: CGRect(x: 0, y: 0, width: 25, height: playerHeight))
        playerTwo.position = CGPoint(x: self.size.width - 50 - playerOne.frame.width, y: self.size.height / 2 - playerTwo.frame.height / 2)
        playerTwo.fillColor = NSColor.white
        self.addChild(playerTwo)
        
        // Add an edge loop body around the scene
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // The scene class itself will handle collisions
        self.physicsWorld.contactDelegate = self

        // Assign category to the outside edge of the game play area
        self.physicsBody?.categoryBitMask = PhysicsCategory.Edge

        // No gravity in the scene
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Add a ball
        ball = GameElement(circleOfRadius: 15)
        ball.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        ball.fillColor = NSColor.white
        self.addChild(ball)
        
        // Set ball movement
        // Diagonally to the bottom left of screen to start
        ball.velocity = CGPoint(x: ballMovementPerSecond * -1, y: ballMovementPerSecond * -1)

        // Give the ball a physics body so contacts with other nodes can be handled
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.width * 0.5)
        
        // Since it's a 2D ball, we don't need to rotate the sprite
        ball.physicsBody?.allowsRotation = false

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
        case 13:
            // W or w key
            playerOne.velocity = CGPoint(x: 0, y: playerMovementPerSecond)
        case 1:
            // S or s key
            playerOne.velocity = CGPoint(x: 0, y: playerMovementPerSecond * -1)
        case 126:
            // Up arrow
            playerTwo.velocity = CGPoint(x: 0, y: playerMovementPerSecond)
        case 125:
            // Down arrow
            playerTwo.velocity = CGPoint(x: 0, y: playerMovementPerSecond * -1)
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
                
        trackTimeElapsed(to: currentTime)
        move(sprite: playerOne)
        move(sprite: playerTwo)
        move(sprite: ball)

    }

    // How much time has elapsed since the last frame was drawn?
    func trackTimeElapsed(to currentTime: TimeInterval) {
        
        if lastUpdateTime > 0 {
            // Update to reflect time elapsed since the last call to update(_:)
            deltaTime = currentTime - lastUpdateTime
        }
        // Log the time of this most recent time update
        lastUpdateTime = currentTime
        //DEBUG: print("\(deltaTime * 1000) milliseconds since last update")

    }
    
    // Move the game element by a fraction of the desired movement per second, based on time since last frame draw
    func move(sprite: GameElement) {
        
        // How much of the desired movement in a second should the game element move for this frame?
        let amountToMove = CGPoint(x: sprite.velocity.x * CGFloat(deltaTime), y: sprite.velocity.y * CGFloat(deltaTime))
        
        // Actually move the sprite
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x,
                                  y: sprite.position.y + amountToMove.y)
        
    }
    
    // This checks to see if a player is at the upper or lower boundary, and if so, reverses their movement vector
    func checkForBoundaryReversal(on player: GameElement) {
        
        // Top of screen, change to moving down
        // OR
        // Bottom of screen, change to moving up
        if player.position.y + player.frame.height > self.size.height ||
            player.position.y < 0
            {
                player.velocity = CGPoint(x: 0, y: player.velocity.y * -1)
        }
        
    }
    
    // Called when two physics bodies collide with one another
    func didBegin(_ contact: SKPhysicsContact) {
        
        // Add the bit masks of the two bodies that have collided
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        print("some kind of contact was registered")
        
        // Do different things based on what two bodies have collided
        switch collision {

        // Contact between a player and the edge of the scene
        case PhysicsCategory.Player | PhysicsCategory.Edge:

            print("contact between edge and player")

            // We don't know whether the player is bodyA or bodyB so we need to figure that out
            if contact.bodyA.categoryBitMask == PhysicsCategory.Player {

                // We need to see this node not as a plain SKShapeNode but as a PlayerElement to change it's velocity
                let player = contact.bodyA.node! as! GameElement
                
                // Reverse the direction of the player
                player.velocity = CGPoint(x: 0, y: player.velocity.y * -1)
                
            } else {

                // We need to see this node not as a plain SKShapeNode but as a PlayerElement to change it's velocity
                let player = contact.bodyB.node! as! GameElement

                // Reverse the direction of the player
                player.velocity = CGPoint(x: 0, y: player.velocity.y * -1)
                
            }
            
        default:
            // Do nothing for any other type of collision
            break
        }
        
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
