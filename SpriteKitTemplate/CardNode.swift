//
//  CardNode.swift
//  SpriteKitTemplate
//
//  Created by Gordon, Russell on 2020-02-12.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import Foundation
import SpriteKit

class CardNode : Card {

    // Actions
    let backTexture : SKTexture
    let firstHalfFlip : SKAction
    let secondHalfFlip : SKAction
    let setTextureToBack : SKAction
    let flipSequence : SKAction

    // An SKSpriteKit node to visually represent this card
    var node : SKSpriteNode
    
    // Initializer
    override init(suit: Suit, rank: Rank) {

        // Initalize the sprite kit node
        self.node = SKSpriteNode(imageNamed: rank.simpleDescription() + suit.briefDescription())
        
        // Set up actions
        backTexture = SKTexture(imageNamed: "RED_BACK")
        firstHalfFlip = SKAction.scaleY(to: 0.0, duration: 0.5)
        secondHalfFlip = SKAction.scaleY(to: 1.0, duration: 0.5)
        setTextureToBack = SKAction.setTexture(backTexture)
        flipSequence = SKAction.sequence([firstHalfFlip, setTextureToBack, secondHalfFlip])
        
        // Call the superclass initializer
        super.init(suit: suit, rank: rank)
        
    }
    
    func flip() {
        // Flip the card
        self.node.run(flipSequence)
    }
    
}
