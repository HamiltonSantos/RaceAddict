//
//  GameScene.swift
//  RaceAddict
//
//  Created by Hamilton on 01/02/18.
//  Copyright © 2018 Hamilton Santos. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var playersCar : SKLabelNode?
    private var bgSky : SKSpriteNode?
    private var bgHills : SKSpriteNode?
    private var bgTrees : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        configureBackground()
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func configureBackground() {
        
        self.bgSky = SKSpriteNode(imageNamed: "sky")
        self.addChild(self.bgSky!)
        
        self.bgHills = SKSpriteNode(imageNamed: "hills")
        self.addChild(self.bgHills!)
        
        self.bgTrees = SKSpriteNode(imageNamed: "trees")
        self.addChild(self.bgTrees!)
    }
}
