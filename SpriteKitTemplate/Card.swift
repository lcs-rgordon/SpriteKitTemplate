//
//  Card.swift
//  AlternateCommandLineWar
//
//  Created by Gordon, Russell on 2020-02-12.
//  Copyright © 2020 Gordon, Russell. All rights reserved.
//

import Foundation
import SpriteKit

// Create a new datatype to represent a playing card
class Card {

    // Properties
    var suit: Suit
    var rank: Rank
    
    // Actions
    let backTexture : SKTexture
    let firstHalfFlip : SKAction
    let secondHalfFlip : SKAction
    let setTextureToBack : SKAction
    let flipSequence : SKAction

    // An SKSpriteKit node to visually represent this card
    var node : SKSpriteNode
    
    // Initializer
    init(suit: Suit, rank: Rank) {
        
        self.suit = suit
        self.rank = rank
        
        // Initalize the sprite kit node
        self.node = SKSpriteNode(imageNamed: rank.simpleDescription() + suit.briefDescription())
        
        // Set up actions
        backTexture = SKTexture(imageNamed: "RED_BACK")
        firstHalfFlip = SKAction.scaleY(to: 0.0, duration: 0.5)
        secondHalfFlip = SKAction.scaleY(to: 1.0, duration: 0.5)
        setTextureToBack = SKAction.setTexture(backTexture)
        flipSequence = SKAction.sequence([firstHalfFlip, setTextureToBack, secondHalfFlip])

    }
    
    // Does the value for this card beat another card?
    //
    func beats(_ otherCard: Card) -> Bool {
        
        // Use the beats method built into the WarRank type
        return self.rank.beats(otherCard.rank)
    }
    
    // Report the simple description of this card
    func simpleDescription() -> String {
        
        // Purely text-based description
        //return self.rank.simpleDescription() + " of " + self.suit.simpleDescription()
        
        // Description using the emoji
        return self.rank.simpleDescription() + " of " + self.suit.glyph
        
    }
    
    func flip() {
        // Flip the card
        self.node.run(flipSequence)
    }
    
}
