//
//  Action.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation

public protocol Action { }

public extension Action {
    func on<T: Action>(_ type: T.Type, code: (T) -> Void) {
        guard let action = self as? T else { return }
        code(action)
    }
    
    func on<T: Action>(_ type: T.Type, code: () -> Void) {
        guard self is T else { return }
        code()
    }
}
