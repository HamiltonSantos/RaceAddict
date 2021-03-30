//
//  ViewController.swift
//  RaceAddict
//
//  Created by Hamilton Carlos Santos on 26/03/21.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameView: SKView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let scene = GameScene(size: gameView.frame.size)
        gameView.showsFPS = true
        gameView.showsNodeCount = true
        gameView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        gameView.presentScene(scene)
        gameView.preferredFramesPerSecond = 60
    }


}

