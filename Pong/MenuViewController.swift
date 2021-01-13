//
//  MenuViewController.swift
//  Pong
//
//  Created by Joshua Dadson on 12/1/20.
//

import UIKit
import MultipeerConnectivity

struct MultipeerManager {
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
}

class MenuViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {
    let singleplayerButton = UIButton()
//    let multiplayerButton = UIButton()
    let hostSessionButton = UIButton()
    let joinSessionButton = UIButton()
    
    var peerManager = MultipeerManager()

    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected To: \(peerID)")
        case MCSessionState.connecting:
            print("Connecting To: \(peerID)")
        case MCSessionState.notConnected:
            print("Not Connected To: \(peerID)")
        }
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.view.backgroundColor = .yellow
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.view.backgroundColor = .yellow
        }
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        peerManager.peerID = MCPeerID(displayName: UIDevice.current.name)
        peerManager.mcSession = MCSession(peer: peerManager.peerID, securityIdentity: nil, encryptionPreference: .required)
        peerManager.mcSession.delegate = self
        
        menuSetup()
        // Do any additional setup after loading the view.
    }
    
    func menuSetup() {
        view.backgroundColor = .white
        
        view.addSubview(singleplayerButton)
        singleplayerButton.translatesAutoresizingMaskIntoConstraints = false
        singleplayerButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        singleplayerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        singleplayerButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        singleplayerButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        singleplayerButton.backgroundColor = .blue
        singleplayerButton.setTitle("Singleplayer", for: .normal)
        singleplayerButton.layer.masksToBounds = true
        
        singleplayerButton.addTarget(self, action: #selector(presentSingleplayerView), for: .primaryActionTriggered)
        
//        view.addSubview(multiplayerButton)
//        multiplayerButton.translatesAutoresizingMaskIntoConstraints = false
//        multiplayerButton.topAnchor.constraint(equalTo: singleplayerButton.bottomAnchor, constant: 50).isActive = true
//        multiplayerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        multiplayerButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        multiplayerButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        multiplayerButton.backgroundColor = .blue
//        multiplayerButton.setTitle("Multiplayer", for: .normal)
//        multiplayerButton.layer.masksToBounds = true
//
//        multiplayerButton.addTarget(self, action: #selector(presentMultiplayerView), for: .primaryActionTriggered)
        
        view.addSubview(hostSessionButton)
        hostSessionButton.translatesAutoresizingMaskIntoConstraints = false
        hostSessionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        hostSessionButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        hostSessionButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hostSessionButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        hostSessionButton.setTitle("Host Session", for: .normal)
        hostSessionButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        hostSessionButton.backgroundColor = .red
        hostSessionButton.addTarget(self, action: #selector(hostSession), for: .primaryActionTriggered)
        
        view.addSubview(joinSessionButton)
        joinSessionButton.translatesAutoresizingMaskIntoConstraints = false
        joinSessionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        joinSessionButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        joinSessionButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        joinSessionButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        joinSessionButton.setTitle("Join Session", for: .normal)
        joinSessionButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        joinSessionButton.backgroundColor = .red
        joinSessionButton.addTarget(self, action: #selector(joinSession), for: .primaryActionTriggered)
    }
    
    @objc func hostSession() {
        print("Host Session")
        peerManager.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "pong-hosting", discoveryInfo: nil, session: peerManager.mcSession)
        peerManager.mcAdvertiserAssistant.start()
    }
    
    @objc func joinSession() {
        print("Join Session")
        let mcBrowser = MCBrowserViewController(serviceType: "browse-sessions", session: peerManager.mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    @objc func presentSingleplayerView() {
        self.navigationController?.pushViewController(GameViewController(), animated: true)
        
    
    }
    
    @objc func presentMultiplayerView() {
        self.navigationController?.pushViewController(MultiplayerViewController(), animated: true)
        
    
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
