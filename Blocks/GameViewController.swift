//
//  GameViewController.swift
//  Blocks
//
//  Created by Lucas Casteletti on 23/08/17.
//  Copyright © 2017 Lucas Casteletti. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import ModelIO

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sceneView = self.view as! SCNView

        sceneView.allowsCameraControl = true
        sceneView.antialiasingMode = .multisampling4X
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true

        let scene = SCNScene()
        sceneView.scene = scene

        // Camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 12, z: 30)
        cameraNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: -sin(12.0/30.0))
        scene.rootNode.addChildNode(cameraNode)

        let cube = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 0)

        guard let img = UIImage(named: "2169505_orig") else {
            fatalError("no img")
        }

        let material = SCNMaterial()
        material.diffuse.contents = img
        material.locksAmbientWithDiffuse = true

        

        cube.materials = [material]


        let cubeNode = SCNNode(geometry: cube)
        scene.rootNode.addChildNode(cubeNode)


        // add a tap gesture recognizer
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        sceneView.addGestureRecognizer(tapGesture)
    }

    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
