//
//  AnyRouteHandler.swift
//  Routing
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

internal struct AnyRouteHandler {
    private let action: (Route) -> Void
    
    init<H: RouteHandler>(handler: H) {
        self.action = { route in
            handler.perform(route as! H.R, context: nil)
        }
    }
    
    func perform(route: Route) {
        action(route)
    }
}
