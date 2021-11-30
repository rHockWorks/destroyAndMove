//
//  TableHealthComponent.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//


import SpriteKit
import GameplayKit


class TableHealthComponent: GKComponent {
  
    var currentHealth   : CGFloat
    var tableNamed      : String
    var tableCleared    : Bool
    
    let objectLevelA    : String
    let objectLevelB    : String
    let objectLevelC    : String
    
    let entityManager   : EntityManager
  
  
    init(currentHealth  : CGFloat,
         tableNamed     : String,
         tableCleared   : Bool,
         
         objectLevelA   : String,
         objectLevelB   : String,
         objectLevelC   : String,
         
         entityManager  : EntityManager) {
      
            self.currentHealth  = currentHealth
            self.tableNamed     = tableNamed
            self.tableCleared   = tableCleared
            
            self.objectLevelA   = objectLevelA
            self.objectLevelB   = objectLevelB
            self.objectLevelC   = objectLevelC
            
            self.entityManager  = entityManager
      
        super.init()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
    func takeDamage(damage: CGFloat, forTable tableAttacked: SpriteComponent, moveData: MoveComponent) {
        
        currentHealth = max(currentHealth - damage, 0)
        
        if currentHealth > 0 && tableCleared == false {

            switch currentHealth {
            case 80...99    :   tableAttacked.node.texture  = SKTexture(imageNamed: objectLevelA)
            case 60...79    :   tableAttacked.node.texture  = SKTexture(imageNamed: objectLevelB)
            case 0...59     :
                                tableAttacked.node.texture  = SKTexture(imageNamed: objectLevelC)
                                self.tableCleared           = true
                                entityManager.setTableToCleared(moveData)
                                print("\n table cleared ~ so why won't he clear another table ?!")
            
            default         :   break
            }
        }
    }
}




