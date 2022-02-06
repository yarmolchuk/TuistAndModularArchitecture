//
//  AggregateState.swift
//  Redux
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation

public protocol AggregateState {
    init(state: State)
}
