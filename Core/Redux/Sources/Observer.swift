//
//  Observer.swift
//  Redux
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Prelude

final public class Observer<T> {
    public let handle: (T) -> ()
    
    public init(handle: @escaping (T) -> ()) {
        self.handle = handle
    }
}
