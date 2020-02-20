//
//  SKCard.swift
//  SpriteKitTemplate
//
//  Created by Gordon, Russell on 2020-02-20.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import Foundation
import SpriteKit

// This subclass will include everything needed to visually represent and manipulate a card using SpriteKit
// NOTE: It deliberately does not store anything about the card – that is kept in the Card instance used to initialize it
class SKCard {
    
    // Actions
    let backTexture: SKTexture
    let frontTexture: SKTexture
    let firstHalfFlip: SKAction
    let secondHalfFlip: SKAction
    let setTextureToBack: SKAction
    let setTextureToFace: SKAction
    let flipToBackSequence: SKAction
    let flipToFaceSequence: SKAction

    // An SKSpriteKit node to visually represent this card
    var node: SKSpriteNode
    
    // Whether the card is face up or face down
    var faceUp: Bool {
        didSet {
            if faceUp {
                self.node.run(setTextureToFace)
            } else {
                self.node.run(setTextureToBack)
            }
        }
    }
    
    // Initializer must set up SpriteKit related properties then call the superclass initializer
    init(card: Card) {

        // Card is face up to start
        faceUp = true
        
        // Initalize the sprite kit node
        node = SKSpriteNode(imageNamed: card.rank.simpleDescription() + card.suit.briefDescription())
        
        // Set up actions
        backTexture = SKTexture(imageNamed: "RED_BACK")
        frontTexture = SKTexture(imageNamed: card.rank.simpleDescription() + card.suit.briefDescription())
        firstHalfFlip = SKAction.scaleY(to: 0.0, duration: 0.5)
        secondHalfFlip = SKAction.scaleY(to: 1.0, duration: 0.5)
        setTextureToBack = SKAction.setTexture(backTexture)
        setTextureToFace = SKAction.setTexture(frontTexture)
        flipToBackSequence = SKAction.sequence([firstHalfFlip, setTextureToBack, secondHalfFlip])
        flipToFaceSequence = SKAction.sequence([firstHalfFlip, setTextureToFace, secondHalfFlip])

    }
    
    // Flips the card, visually
    func flip(faceUp: Bool) {
        // Flip the card
        if faceUp {
            self.node.run(flipToFaceSequence)
        } else {
            self.node.run(flipToBackSequence)
        }
    }
    
}
