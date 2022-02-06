//
//  Router.swift
//  Routing
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Prelude
import Foundation

public protocol Route { }

extension Route {
    static var identifier: ObjectIdentifier {
        get {
            ObjectIdentifier(Self.self)
        }
    }
}

final public class Router {
    private static var handlers: [ObjectIdentifier: AnyRouteHandler] = [:]
    
    public static func register<H>(handler: H) where H: RouteHandler {
        dispatchPrecondition(condition: .onQueue(.main))
        
        guard handlers.keys.contains(H.R.identifier) == false else {
            fatalError("Can not register handler")
        }
        handlers[H.R.identifier] = AnyRouteHandler(handler: handler)
    }
    
    public static func perform(route: Route) {
        dispatchPrecondition(condition: .onQueue(.main))
        
        let handler = handlers[type(of: route).identifier]
        handler!.perform(route: route)
    }
}

public extension Router {
    static func bind<R: Route>(route: R) -> Command {
        Command {
            self.perform(route: route)
        }
    }
    
    static func bind<R: Route>(routeCreator: @escaping() -> R) -> Command {
        Command {
            self.perform(route: routeCreator())
        }
    }
}
