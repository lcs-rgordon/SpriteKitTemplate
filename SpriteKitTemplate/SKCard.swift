//
//  SKCard.swift
//  SpriteKitTemplate
//
//  Created by Gordon, Russell on 2020-02-20.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import Foundation
import SpriteKit

// This subclass will include everything needed to visually represent and manipulate the card using SpriteKit
class SKCard: Card {
    
    // Actions
    let backTexture : SKTexture
    let firstHalfFlip : SKAction
    let secondHalfFlip : SKAction
    let setTextureToBack : SKAction
    let flipSequence : SKAction

    // An SKSpriteKit node to visually represent this card
    var node : SKSpriteNode
    
    // Initializer must set up SpriteKit related properties then call the superclass initializer
    override init(suit: Suit, rank: Rank) {
        
        // Initalize the sprite kit node
        node = SKSpriteNode(imageNamed: rank.simpleDescription() + suit.briefDescription())
        
        // Set up actions
        backTexture = SKTexture(imageNamed: "RED_BACK")
        firstHalfFlip = SKAction.scaleY(to: 0.0, duration: 0.5)
        secondHalfFlip = SKAction.scaleY(to: 1.0, duration: 0.5)
        setTextureToBack = SKAction.setTexture(backTexture)
        flipSequence = SKAction.sequence([firstHalfFlip, setTextureToBack, secondHalfFlip])
        
        // Initialize the superclass
        super.init(suit: suit, rank: rank)
    }
    
    // Flips the card, visually
    func flip() {
        // Flip the card
        self.node.run(flipSequence)
    }
    
}
