//
//  MoveComponent.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//


import SpriteKit
import GameplayKit


class MoveComponent: GKAgent2D, GKAgentDelegate {

    let entityManager: EntityManager

    
    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
        
        self.entityManager      = entityManager
        super.init()
        delegate                = self
        self.maxSpeed           = maxSpeed
        self.maxAcceleration    = maxAcceleration
        self.radius             = radius
        self.mass               = 0.01
    }
  
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }


    
    func agentWillUpdate(_ agent: GKAgent) {
        
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else { return }

        position = SIMD2(spriteComponent.node.position)
    }


    func agentDidUpdate(_ agent: GKAgent) {
        
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else { return }

        spriteComponent.node.position = CGPoint(position)
    }
    
    
    func closestMoveComponent(for request: Object) -> GKAgent2D? {

        var closestMoveComponent: MoveComponent? = nil
        var closestDistance = CGFloat(0)
        let moveComponents  = entityManager.tableComponents(for: request)
        
        for moveComponent in moveComponents {
            
            let distance = (CGPoint(moveComponent.position) - CGPoint(position)).length()
            
            if closestMoveComponent == nil || distance < closestDistance {
                    closestMoveComponent    = moveComponent
                    closestDistance         = distance
            }
        }
        return closestMoveComponent
    }
    

    override func update(deltaTime seconds: TimeInterval) {

        super.update(deltaTime: seconds)
        
        guard let closestTableComponent     = closestMoveComponent(for: .foodTable)                                         else { return }
        guard let foodTableDetailComponent  = closestTableComponent.entity?.component(ofType: TableHealthComponent.self)    else { return }
        
        if foodTableDetailComponent.tableCleared == false {
        
            let clearedTables = entityManager.foodTablesCleared
            
            behavior = MoveBehavior(targetSpeed: maxSpeed, seek: closestTableComponent, avoid: clearedTables)
            }
        }
    }
