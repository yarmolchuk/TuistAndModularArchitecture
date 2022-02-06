//
//  DomainState.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

public protocol DomainState {
    static var initial: Self { get }
    
    mutating func reduce(_ action: Action)
}
