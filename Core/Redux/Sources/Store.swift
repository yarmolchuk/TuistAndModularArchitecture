//
//  Store.swift
//  Redux
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Prelude
import Foundation

final public class Store {
    private var state = State()
    private var observers = [] as [AnyObserver]
    
    let queue = DispatchQueue(label: "store")

    public init() { }
    
    public func dispatch(action: Action) {
        dispatch { _ in action }
    }
    
    public func dispatch<D: DomainState>(actionCreator: @escaping (D) -> Action) {
        dispatch { state in actionCreator(state.get()) }
    }
    
    public func observe<D: DomainState>(with observer: Observer<D>) {
        Environment.timeline.schedule(on: queue) { [self] in
            if !state.slices.keys.contains(ObjectIdentifier(D.self)) {
                state.slices[ObjectIdentifier(D.self)] = D.initial
            }
            observers.append(AnyObserver(observer: observer))
            observer.handle(state.get())
        }
    }
    
    public func observe<A: AggregateState>(with observer: Observer<A>) {
        Environment.timeline.schedule(on: queue) { [self] in
            observers.append(AnyObserver(observer: observer))
            observer.handle(A(state: state))
        }
    }
    
    private func dispatch(actionCreator: @escaping (State) -> Action) {
        Environment.timeline.schedule(on: queue) { [self] in
            let action = actionCreator(state)
            print("[Store] Dispatching: ", action)
            state.reduce(action)
            
            for observer in observers {
                observer.handle(state)
            }
        }
    }
}

public extension Store {
    func bind(_ action: Action) -> CommandWith<Void> {
        CommandWith { [self] in
            dispatch(action: action)
        }
    }
    
    func bind<T>(_ actionCreator: @escaping (T) -> Action) -> CommandWith<T> {
        CommandWith { [self] value in
            dispatch(action: actionCreator(value))
        }
    }
}
