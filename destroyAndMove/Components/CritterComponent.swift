//
//  CritterComponent.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//


import SpriteKit
import GameplayKit


class CritterComponent: GKComponent {

    var totalCritters       = 10                // Total number of Critters for Stage
    var critterAllowance    = 1                 // Total Critters allowed on Scene at any one time
    var currentCritters     = 0                 // Current number of Critters on Scene
    var crittersBeaten      = 0                 // Total number of Critter presently beaten
    var birth               = false             // Can a Critter be created
    var lastSpawn           = TimeInterval(0)
    

    override init() {
    
        super.init()
    }
  
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

  
    override func update(deltaTime seconds: TimeInterval) {

        super.update(deltaTime: seconds)
  
        let coinDropInterval = TimeInterval(5.0)
        
        if (CACurrentMediaTime() - lastSpawn > coinDropInterval) {
            if currentCritters < critterAllowance {
                if (crittersBeaten + currentCritters) < totalCritters {
                    birth       = true
                    lastSpawn   = CACurrentMediaTime()
                }
            }
        }
    }
}

