//
//  StageComponent.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 30/11/2021.
//


import GameplayKit



class StageComponent: GKComponent {
    
    var exitNodes: [CGPoint] = []
    
    
    init(exitNodes: [CGPoint]) {
        
        self.exitNodes = exitNodes
        
        super.init()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
