//
//  SKHand.swift
//  SpriteKitTemplate
//
//  Created by Gordon, Russell on 2020-02-20.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import Foundation
import SpriteKit

class SKHand {

    // The array of cards to be shown
    var visualCards: [SKCard]
    
    // Initializer
    init(cards: [Card]) {
        
        // Initialize the hand
        visualCards = []
        
        // Loop through the cards given and create SpriteKit versions
        for aCard in cards {
            visualCards.append(SKCard(card: aCard))
        }
        
    }
    
    // Display the hand
    func display(anchor: CGPoint, spacing: Int, faceUp: Bool, on scene: SKScene) {
        
        for (i, card) in visualCards.enumerated() {
            card.faceUp = faceUp
            card.node.position = CGPoint(x: anchor.x + CGFloat(i * spacing), y: anchor.y)
            scene.addChild(card.node)
        }
        
    }
    
}
