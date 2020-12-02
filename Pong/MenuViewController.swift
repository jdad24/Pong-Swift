//
//  MenuViewController.swift
//  Pong
//
//  Created by Joshua Dadson on 12/1/20.
//

import UIKit

class MenuViewController: UIViewController {
    let demoButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSetup()
        // Do any additional setup after loading the view.
    }
    
    func menuSetup() {
        view.backgroundColor = .white
        
        view.addSubview(demoButton)
        demoButton.translatesAutoresizingMaskIntoConstraints = false
        demoButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        demoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        demoButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        demoButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        demoButton.backgroundColor = .blue
        demoButton.setTitle("Play Demo", for: .normal)
        
        demoButton.addTarget(self, action: #selector(presentDemo), for: .primaryActionTriggered)
        
    }
    
    @objc func presentDemo() {
        self.navigationController?.pushViewController(GameViewController(), animated: true)
        
    
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
