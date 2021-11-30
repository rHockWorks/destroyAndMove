//
//  MoveBehaviour.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//


import GameplayKit
import SpriteKit


class MoveBehavior: GKBehavior {

    init(targetSpeed: Float, seek: GKAgent, avoid: [GKAgent]) {
    
        super.init()
      
        if targetSpeed > 0 {

            setWeight(0.5, for: GKGoal(toReachTargetSpeed: targetSpeed))
        
            setWeight(0.6, for: GKGoal(toSeekAgent: seek))
        
            setWeight(1.0, for: GKGoal(toAvoid: avoid, maxPredictionTime: 1.0))
        }
    }
}

