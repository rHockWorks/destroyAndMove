//
//  TableDetailComponent.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 30/11/2021.
//

import GameplayKit


class TableDetailComponent: GKComponent, GKAgentDelegate {
    
    var nameData: String

    init(nameData: String) {
        
        self.nameData = nameData
        
        super.init()
    }
  
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
