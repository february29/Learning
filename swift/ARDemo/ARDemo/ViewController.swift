//
//  ViewController.swift
//  ARDemo
//
//  Created by bai on 2019/5/28.
//  Copyright © 2019 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController ,ARSCNViewDelegate,ARSessionDelegate{
    
    
   
    //场景
   lazy var sceneView: ARSCNView  = {
        let  sceneView = ARSCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height));
        sceneView.showsStatistics = true;
        sceneView.autoenablesDefaultLighting = true
        
        return sceneView;
    }()

//    会话
    lazy var sesson: ARSession = {
        let temp = ARSession();
        temp.delegate = self;
        return temp;
    }()
    
    lazy var scene: SCNScene = {
        // 存放所有 3D 几何体的容器
        let scene = SCNScene()
       
        
        return scene;
    }()
    
    //小树人
    lazy var treeNode: SCNNode = {
        
        let temp = SCNNode();
        
        guard  let url = Bundle.main.url(forResource: "linglang", withExtension: "max") else {
            fatalError("baby_groot.dae not exit.")
        }
        guard let customNode = SCNReferenceNode(url: url) else {
            fatalError("load baby_groot error.")
        }
        customNode.load();
        temp.addChildNode(customNode)
        
         temp.position = SCNVector3Make(0, 0, -0.5);
        return temp;
    }()
    

    //红色立方体
    lazy var redNode: SCNNode = {
        
        // 想要绘制的 3D 立方体
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0)
        boxGeometry.firstMaterial?.diffuse.contents = UIColor.red;
        // 将几何体包装为 node 以便添加到 scene
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3Make(0, 0, -0.5);
        
        return boxNode;
    }()
    
    //相机节点 代表第一视角的位置。 空节点
    lazy var selfNode: SCNNode = {
        let temp = SCNNode()
        
        return temp;
    }()
    
    
    //
    lazy var boxNode: SCNNode = {
       
        // 想要绘制的 3D 立方体
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0)
        
        // 将几何体包装为 node 以便添加到 scene
        let boxNode = SCNNode(geometry: boxGeometry)
        
        
        return boxNode;
    }()
   
    
    lazy var configuration:ARWorldTrackingConfiguration = {
        
        let temp =  ARWorldTrackingConfiguration();
        temp.isLightEstimationEnabled = true;
        temp.planeDetection = .horizontal;
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.sceneView.session = self.sesson;
        self.sceneView.delegate = self;
        self.view.addSubview(sceneView);
        
        // rootNode 是一个特殊的 node，它是所有 node 的起始点
        self.scene.rootNode.addChildNode(self.redNode)
      
        self.sceneView.scene = self.scene
        
        
        self.scene.rootNode.addChildNode(self.treeNode)
       
        
        
        
        //ARSCNView 的scene 为 SCNScene  ，SCNScene的rootNode 添加子node

        
        

        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        self.sceneView.session.run(self.configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        self.sceneView.session.pause()
    }

    
    
    //MARK:ARSCNViewDelegate 继承自 ARSessionObserver
    
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        print("添加锚点")
    }
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        print("相机移动: (x: \(frame.camera.transform.columns.3.x) y:\(frame.camera.transform.columns.3.y) z:\(frame.camera.transform.columns.3.z))")
       
        
//        if self.node != nil {
//             self.node.position = SCNVector3Make(frame.camera.transform.columns.3.x,frame.camera.transform.columns.3.y,frame.camera.transform.columns.3.z);
//        }
        
        selfNode.position = SCNVector3Make(frame.camera.transform.columns.3.x,frame.camera.transform.columns.3.y,frame.camera.transform.columns.3.z);
       
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
         print("更新锚点")
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    //MARK:ARSCNViewDelegate
    
    ////添加节点时候调用（当开启平地捕捉模式之后，如果捕捉到平地，ARKit会自动添加一个平地节点）
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("添加节点");
        
//        if anchor.isMember(of: ARPlaneAnchor.self) {
//            print("捕捉到平地");
//
//
//            let planeAnchor = anchor as! ARPlaneAnchor;
//            self.boxNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
//            node.addChildNode(self.boxNode)
//        }
//
    }

    
    
    //点击屏幕。
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event);
        
        self.nodeAroundAnimation();
        
        self.treeRotation();
    }
    
    func treeRotation()  {
        //旋转核心动画
        let moonRotationAnimation = CABasicAnimation(keyPath: "rotation");
        
        //旋转周期
        moonRotationAnimation.duration = 5;
        
        //围绕Y轴旋转360度
        moonRotationAnimation.toValue = NSValue(scnVector4: SCNVector4Make(0, 1, 0, Float(M_PI*2)));
        //无限旋转  重复次数为无穷大
        moonRotationAnimation.repeatCount = Float.greatestFiniteMagnitude;
        
        //开始旋转  ！！！：切记这里是让空节点旋转，而不是台灯节点。  理由同上
        treeNode.addAnimation(moonRotationAnimation, forKey: "tree rotation around self");
        
    }
    
    
    func nodeAroundAnimation()  {
        //3.绕相机旋转
        //绕相机旋转的关键点在于：在相机的位置创建一个空节点，然后将台灯添加到这个空节点，最后让这个空节点自身旋转，就可以实现台灯围绕相机旋转
        //1.为什么要在相机的位置创建一个空节点呢？因为你不可能让相机也旋转
        //2.为什么不直接让台灯旋转呢？ 这样的话只能实现台灯的自转，而不能实现公转
        
        
        //空节点位置与相机节点位置一致
        selfNode.position = self.sceneView.scene.rootNode.position;
        
        //将空节点添加到相机的根节点
        self.sceneView.scene.rootNode.addChildNode(selfNode)
        
        // !!!将移动节点作为自己节点的子节点，如果不这样，那么你将看到的是台灯自己在转，而不是围着你转
        
        selfNode.addChildNode(self.redNode)
        
        
        //旋转核心动画
        let moonRotationAnimation = CABasicAnimation(keyPath: "rotation");
        
        //旋转周期
        moonRotationAnimation.duration = 5;
        
        //围绕Y轴旋转360度
        moonRotationAnimation.toValue = NSValue(scnVector4: SCNVector4Make(0, 1, 0, Float(M_PI*2)));
        //无限旋转  重复次数为无穷大
        moonRotationAnimation.repeatCount = Float.greatestFiniteMagnitude;
        
        //开始旋转  ！！！：切记这里是让空节点旋转，而不是台灯节点。  理由同上
        selfNode.addAnimation(moonRotationAnimation, forKey: "moon rotation around earth");
        
        
    }
}

