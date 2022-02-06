//
//  State.swift
//  Redux
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Prelude

public struct State {
    var slices = [:] as [ObjectIdentifier : DomainState]
    
    public func get<D: DomainState>() -> D {
        slices[ObjectIdentifier(D.self)] as! D
    }
    
    mutating public func reduce(_ action: Action) {
        for key in slices.keys { slices[key]?.reduce(action) }
    }
}
