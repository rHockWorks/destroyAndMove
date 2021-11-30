//
//  EntityManager.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//


import Foundation
import SpriteKit
import GameplayKit



class EntityManager {

    lazy var componentSystems: [GKComponentSystem] = {
        let moveSystem          = GKComponentSystem(componentClass: MoveComponent.self)
        let meleeSystem         = GKComponentSystem(componentClass: MeleeComponent.self)
        let critterComponent    = GKComponentSystem(componentClass: CritterComponent.self)
        return [moveSystem, meleeSystem, critterComponent]
    }()

//    var toRemove = Set<GKEntity>()
    var foodTablesCleared   = [GKAgent]()
    var entities            = Set<GKEntity>()
    let scene: SKScene

    
    init(scene: SKScene) { self.scene = scene }


    func add(_ entity: GKEntity) {
    
        entities.insert(entity)

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            scene.addChild(spriteNode)
        }
        
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }

    
    func update(_ deltaTime: CFTimeInterval) {
      
        // FIXME: Possible speed hog ?
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        guard let critterAI             = getEntities(for: .stage),
              let critterAIComponent    = critterAI.component(ofType: CritterComponent.self) else { return }
        
        
        if critterAIComponent.birth == true {
            spawnCrtitter()
            critterAIComponent.currentCritters += 1
            critterAIComponent.birth = false
        }

//        for currentRemove in toRemove {
//            for componentSystem in componentSystems {
//                componentSystem.removeComponent(foundIn: currentRemove)
//            }
//        }
//        toRemove.removeAll()
    }



    func setTableToCleared(_ entity: GKAgent) {
        
        foodTablesCleared.append(entity)
    }
    


    func getArrayOfEntities(for request: Object) -> [GKEntity] {
    
        return entities.compactMap { entity in
            if let objectComponent = entity.component(ofType: ObjectTypeComponent.self) {
                if objectComponent.objectType == request { return entity }
            }
            return nil
        }
    }
    
    
    func getEntities(for request: Object) -> GKEntity? {
        
        for entity in entities {
            if let objectComponent = entity.component(ofType: ObjectTypeComponent.self) {
                if objectComponent.objectType == request { return entity }
            }
        }
        return nil
    }
    
    
    func moveComponents(for request: Object) -> [MoveComponent] {
        
        let entitiesToMove = getArrayOfEntities(for: request)
        var moveComponents = [MoveComponent]()
        
        for entity in entitiesToMove {
            if let moveComponent = entity.component(ofType: MoveComponent.self) {
                moveComponents.append(moveComponent)
            }
        }
        return moveComponents
    }
    
    
    func tableComponents(for request: Object) -> [MoveComponent] {
        
        let entitiesToLocate = getArrayOfEntities(for: request)
        var tableComponents = [MoveComponent]()
        
        for entity in entitiesToLocate {
            if let tableComponent = entity.component(ofType: MoveComponent.self) {
                tableComponents.append(tableComponent)
            }
        }
        return tableComponents
    }
    
    
    private func spawnCrtitter() {
        
        guard let stage = getEntities(for: .stage),
              let stageComponent = stage.component(ofType: StageComponent.self) else { return }
        
        let randomPosition: CGPoint = stageComponent.exitNodes.randomElement() ?? CGPoint.zero
        
        let critter = generateCritter(entityManager: self)
        
        if let spriteComponent = critter.component(ofType: SpriteComponent.self) {
            spriteComponent.node.name       = "critter"
            spriteComponent.node.position   = randomPosition
            spriteComponent.node.zPosition  = 2
        }
        add(critter)
    }
    
    
    func generateCritter(entityManager: EntityManager) -> Critter {
        
        return Critter(texture: "critter", entityManager: entityManager)
    }
    



}
