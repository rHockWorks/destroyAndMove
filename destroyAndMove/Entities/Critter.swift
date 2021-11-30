//
//  Critter.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//


import GameKit


class Critter: GKEntity {
    
    var texture         : String
    var entityManager   : EntityManager
    
    init(texture: String, entityManager  : EntityManager) {
                
        self.texture        = texture
        self.entityManager  = entityManager
        
        super.init()
        
        // GK Components
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: texture))
        addComponent(spriteComponent)
        
        addComponent(ObjectTypeComponent(objectType: .critter))
        
        addComponent(MoveComponent(maxSpeed         : 150,
                                   maxAcceleration  : 5,
                                   radius           : Float(10),
                                   entityManager    : entityManager))
        
        addComponent(MeleeComponent(damage          : 20,
                                    destroySelf     : false,
                                    damageRate      : 1,
                                    aoe             : true,
                                    entityManager   : entityManager))
        
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
}
