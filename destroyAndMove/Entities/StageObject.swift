//
//  StageFoodTable.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//

import SpriteKit
import GameKit


class StageObject: GKEntity {
        
    var type            : Object
    var named           : String
    var texture         : String
    var positioned      : CGPoint
    var entityManager   : EntityManager
    var currentHealth   : CGFloat
    var tableCleared    : Bool          = false

    var objectLevelA    : String
    var objectLevelB    : String
    var objectLevelC    : String

    
    init(type           : Object,
         named          : String,
         texture        : String,
         positioned     : CGPoint,
         currentHealth  : CGFloat,
         entityManager  : EntityManager,
         
         objectLevelA   : String,
         objectLevelB   : String,
         objectLevelC   : String) {
        
        self.type           = type
        self.named          = named
        self.texture        = texture
        self.positioned     = positioned
        self.currentHealth  = currentHealth
        self.entityManager  = entityManager
        
        self.objectLevelA   = objectLevelA
        self.objectLevelB   = objectLevelB
        self.objectLevelC   = objectLevelC
        
        super.init()
        
        // GK Components
        let spriteComponent             = SpriteComponent(texture: SKTexture(imageNamed: texture))
        spriteComponent.node.position   = positioned
        addComponent(spriteComponent)
                
        addComponent(ObjectTypeComponent(objectType: type))
        
        addComponent(MoveComponent(maxSpeed: 0, maxAcceleration: 0, radius: Float(10), entityManager: entityManager))
        
        addComponent(TableDetailComponent(nameData: named))
        
        addComponent(TableHealthComponent(currentHealth : currentHealth,
                                          tableNamed    : named,
                                          tableCleared  : false,
                                          
                                          objectLevelA  : objectLevelA,
                                          objectLevelB  : objectLevelB,
                                          objectLevelC  : objectLevelC,
                                          
                                          entityManager : entityManager))
    
        }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
