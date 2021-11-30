//
//  Stage.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//

import Foundation
import GameplayKit


class Stage: GKEntity {

    let name        : StageNames
    let scene       : SKScene
    var exitNodes   : [CGPoint] = []
    
    init(name: StageNames, entityManager: EntityManager, scene: SKScene) {
        
        self.name   = name
        self.scene  = scene
        
        super.init()

        addComponent(ObjectTypeComponent(objectType: .stage))
        
        addComponent(CritterComponent())
        
        scene.enumerateChildNodes(withName: "ExitNode") { node, stop in
            self.exitNodes.append(node.position)
        }

        addComponent(StageComponent(exitNodes: exitNodes))
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
