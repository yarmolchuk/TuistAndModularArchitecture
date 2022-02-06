//
//  AnyObserver.swift
//  Redux
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Prelude

final class AnyObserver {
    let handle: (State) -> ()

    init<D: DomainState>(observer: Observer<D>) {
        self.handle =  {
            observer.handle($0.get())
        }
    }
    
    init<A: AggregateState>(observer: Observer<A>) {
        self.handle =  {
            observer.handle(A(state: $0))
        }
    }
}
