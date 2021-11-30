//
//  MeleeComponent.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//


import Foundation
import SpriteKit
import GameplayKit


class MeleeComponent: GKComponent {
  
    let damage          : CGFloat
    let destroySelf     : Bool
    let damageRate      : CGFloat
    var lastDamageTime  : TimeInterval
    let aoe             : Bool
    let entityManager   : EntityManager
  
    
    init(damage: CGFloat, destroySelf: Bool, damageRate: CGFloat, aoe: Bool, entityManager: EntityManager) {
        
        self.damage         = damage
        self.destroySelf    = destroySelf
        self.damageRate     = damageRate
        self.aoe            = aoe
        self.lastDamageTime = 0
        self.entityManager  = entityManager
        super.init()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    override func update(deltaTime seconds: TimeInterval) {
    
        super.update(deltaTime: seconds)
    
        guard let critterSpriteComponent = entity?.component(ofType: SpriteComponent.self) else { return }
            
        var aoeDamageCaused = false
        let tableEntities   = entityManager.getArrayOfEntities(for: .foodTable)
        
        for tableEntity in tableEntities {

            guard let tableSpriteComponent  = tableEntity.component(ofType: SpriteComponent.self),
                let detailsComponent        = tableEntity.component(ofType: TableDetailComponent.self),
                let tableHealthComponent    = tableEntity.component(ofType: TableHealthComponent.self),
                let tableMovementComponent  = tableEntity.component(ofType: MoveComponent.self) else { continue }
            
            tableSpriteComponent.node.name = detailsComponent.nameData

            if !tableHealthComponent.tableCleared {
                if (critterSpriteComponent.node.calculateAccumulatedFrame().intersects(tableSpriteComponent.node.calculateAccumulatedFrame())) {
                    if (CGFloat(CACurrentMediaTime() - lastDamageTime) > damageRate) {
                        if (aoe) {
                            aoeDamageCaused = true
                        } else {
                            lastDamageTime = CACurrentMediaTime()
                        }
                            tableHealthComponent.takeDamage(damage: damage, forTable: tableSpriteComponent, moveData: tableMovementComponent)
                        }
                    }
                }
            }
        
        if (aoeDamageCaused) {
          lastDamageTime = CACurrentMediaTime()
        }
    }
    
}

