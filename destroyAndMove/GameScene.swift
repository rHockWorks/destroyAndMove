//
//  GameScene.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    

    var entityManager           : EntityManager!
    var lastUpdateTimeInterval  : TimeInterval = 0

    
    func generateFoodTable(named: String, positioned: CGPoint, entityManager: EntityManager) -> StageObject {

        return  StageObject(type            : .foodTable,
                            named           : named,
                            texture         : "table",
                            positioned      : positioned,
                            currentHealth   : 100,
                            entityManager   : entityManager,

                            objectLevelA    : "deg1",
                            objectLevelB    : "deg2",
                            objectLevelC    : "deg3")
    }


    override func didMove(to view: SKView) {
        
        entityManager = EntityManager(scene: self)
        
        let tableData = ["Table1" : CGPoint(x: -400,    y: 200),
                         "Table2" : CGPoint(x: -100,    y: 200),
                         "Table3" : CGPoint(x: 300,     y: 200),
                         "Table4" : CGPoint(x: 200,     y: -100)]
        
        for data in tableData {
            let table = generateFoodTable(named: data.key, positioned: data.value, entityManager: entityManager)
            entityManager.add(table)
        }
        
        let stage = Stage(name: .stage1, entityManager: entityManager, scene: self)
        entityManager.add(stage)
    }
    
    

    override func update(_ currentTime: CFTimeInterval) {
           
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime

        entityManager.update(deltaTime)
    }
}
