//
//  MultiplayerViewController.swift
//  Pong
//
//  Created by Joshua Dadson on 12/6/20.
//

import UIKit
import SpriteKit

class MultiplayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = SKView()
//        view.backgroundColor = .gray
        
        if let view = self.view as? SKView {
            let scene = MultiplayerScene()
            scene.size = CGSize(width: 750, height: 1334)
            scene.anchorPoint = CGPoint(x: 0, y: 0)
            scene.scaleMode = .aspectFill
                
            view.presentScene(scene)
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.ignoresSiblingOrder = true
        }

        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
