//
//  ObjectType.swift
//  destroyAndMove
//
//  Created by Rudolph Hock on 29/11/2021.
//


import GameplayKit


class ObjectTypeComponent: GKComponent {
  
    let objectType: Object

    
    init(objectType: Object) {
        
        self.objectType = objectType
    
        super.init()
    }
  
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


