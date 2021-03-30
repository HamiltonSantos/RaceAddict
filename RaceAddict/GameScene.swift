//
//  GameScene.swift
//  RaceAddict
//
//  Created by Hamilton Carlos Santos on 26/03/21.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "GameAssets/twilightCity")
    let leftButton = SKSpriteNode(imageNamed: "GameAssets/leftButton")
    let rightButton = SKSpriteNode(imageNamed: "GameAssets/rightButton")
    let gasButton = SKSpriteNode(imageNamed: "GameAssets/gasButton")
    var player = SKSpriteNode()
    var playerFrames: [SKTexture] = []
    
    var width:CGFloat = 0
    var height:CGFloat = 0
    var segments:[SKTexture] = []
    var roadWidth:Float = 2000
    var segmentLength:Float = 200
    var rumbleLength:Float = 3
    var trackLength:Float = 0
    var lanes:Int = 3
    var fieldOfView:Float = 100
    var cameraHeight:Float = 1000
    var cameraDepth:Float = 0
    var drawDistance:Float = 300
    var playerX:Float = 0
    var playerZ:Float = 0
    var fogDensity:Float = 5
    var playerPosition:Float = 0
    var playerSpeed:Float = 0
    var maxSpeed:Float = 0
    var accel:Float = 0
    var breaking:Float = 0
    var decel:Float = 0
    var offRoadDecel:Float = 0
    var offRoadLimit:Float = 0
    
    
    var leftTouched = false
    var rightTouched = false
    var gasTouched = false
    
    
    
    override func didMove(to view: SKView) {
        
        width = view.frame.width
        height = view.frame.height
        maxSpeed = segmentLength
        accel = maxSpeed/5
        breaking = -maxSpeed
        decel = -maxSpeed/5
        offRoadDecel = -maxSpeed/2
        offRoadLimit = maxSpeed/4
        
        background.position = CGPoint(x:view.frame.midX,y:(self.size.height/4)*3)
        background.scale(to: CGSize(width: self.size.width, height: self.size.height/2))
        addChild(background)
        
        leftButton.position = CGPoint(x: 60, y: 60)
        leftButton.setScale(3)
        leftButton.name = "leftButton"
        addChild(leftButton)
        
        rightButton.position = CGPoint(x: 140, y: 60)
        rightButton.setScale(3)
        rightButton.name = "rightButton"
        addChild(rightButton)
        
        gasButton.position = CGPoint(x: frame.size.width-80, y: 60)
        gasButton.setScale(3)
        gasButton.name = "gasButton"
        addChild(gasButton)
        
        
        self.isUserInteractionEnabled = true
        
        
        buildPlayer()
        animatePlayer()
        
        for child in self.children {
            if let child = child as? SKSpriteNode {
                child.texture?.filteringMode = .nearest
            }
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
    }
    
    func buildPlayer() {
        let playerAnimatedAtlas = SKTextureAtlas(named: "redCar")
        var frames: [SKTexture] = []
        
        let numImages = playerAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let playerTextureName = "red\(i)"
            frames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        playerFrames = frames
        
        let firstFrameTexture = playerFrames[0]
        player = SKSpriteNode(texture: firstFrameTexture)
        player.position = CGPoint(x: frame.midX, y: frame.midY/3)
        player.setScale(2)
        addChild(player)
    }
    
    func animatePlayer() {
        player.run(SKAction.repeatForever(
                    SKAction.animate(with: playerFrames,
                                     timePerFrame: 0.5,
                                     resize: false,
                                     restore: true)),
                   withKey:"racingCar")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let positionInScene = touch.location(in: self)
            let touchedNodes = self.nodes(at: positionInScene)
            for node in touchedNodes {
                switch node.name {
                case "leftButton":
                    leftTouched = true
                case "rightButton":
                    rightTouched = true
                case "gasButton":
                    gasTouched = true
                default:
                    break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let positionInScene = touch.location(in: self)
            let touchedNodes = self.nodes(at: positionInScene)
            for node in touchedNodes {
                switch node.name {
                case "leftButton":
                    leftTouched = false
                case "rightButton":
                    rightTouched = false
                case "gasButton":
                    gasTouched = false
                default:
                    break
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        playerPosition = playerPosition+(Float(currentTime) * playerSpeed)
        
        var dx = Float(currentTime)*(2*(playerSpeed/maxSpeed))
        
        if leftTouched {
                playerX = playerX - dx
        } else if rightTouched {
            playerX = playerX + dx
        }
        if gasTouched {
            playerSpeed = playerSpeed+(accel*Float(currentTime))
//        } else if !gasTouched {
//        speed = Util.accelerate(speed, breaking, dt)
        } else {
            playerSpeed = playerSpeed+(decel*Float(currentTime))
        }
        if (((playerX < -1) || (playerX > 1)) && (playerSpeed > offRoadLimit)) {
            playerSpeed = playerSpeed + (offRoadDecel*Float(currentTime))
        }
//        playerX = Util.limit(playerX, -2, 2);     // dont ever let player go too far out of bounds
//        speed   = Util.limit(speed, 0, maxSpeed); // or exceed maxSpeed
        
        print(playerPosition)
    }

//    func resetRoad() {
//      segments = [];
//        for n in  0...500 { // arbitrary road length
//        segments.push({
//           index: n,
//           p1: { world: { z:  n   *segmentLength }, camera: {}, screen: {} },
//           p2: { world: { z: (n+1)*segmentLength }, camera: {}, screen: {} },
//           color: Math.floor(n/rumbleLength)%2 ? COLORS.DARK : COLORS.LIGHT
//        });
//      }
//
//      trackLength = segments.length * segmentLength;
//    }
}
