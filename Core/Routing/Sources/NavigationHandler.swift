//
//  NavigationHandler.swift
//  Routing
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import UIKit

final public class NavigationHandler<Handler>:RouteHandler where Handler: RouteHandler {
    public let handler: Handler
    public let navigationController: UINavigationController

    public init(handler: Handler, navigationController: UINavigationController) {
        self.handler = handler
        self.navigationController = navigationController
    }
    
    public func perform(_ route: Handler.R, context: RouteContext?) {
        let childContext = RouteContext { [self] controller in
            if navigationController.viewControllers.isEmpty {
                navigationController.viewControllers = [controller]
            } else {
                navigationController.pushViewController(controller, animated: true)
            }
        }
        handler.perform(route, context: childContext)
        context?.present(navigationController)
    }
}

public struct CurrentNavigationHandler<Handler>:RouteHandler where Handler: RouteHandler {
    let childHandler: Handler
    let window: UIWindow
    
    public func perform(_ route: Handler.R, context: RouteContext?) {
        let tabbar = window.rootViewController as? UITabBarController
        let navigationController: UINavigationController = tabbar?.selectedViewController as! UINavigationController
            
        let childContext = RouteContext { controller in
            navigationController.pushViewController(controller, animated: true)
        }
        childHandler.perform(route, context: childContext)
    }
}

public struct NavigationPush<R: Route> : Route {
    public let content: R
}

public struct NestedNavigationHandler<Handler>: RouteHandler where Handler: RouteHandler {
    let childHandler: Handler
    let window: UIWindow

    public func perform(_ route: NavigationPush<Handler.R>, context: RouteContext?) {
        let tabbar = window.rootViewController as? UITabBarController
        let navigationController: UINavigationController = tabbar?.selectedViewController as! UINavigationController
            
        let childContext = RouteContext { controller in
            navigationController.pushViewController(controller, animated: true)
        }
        childHandler.perform(route.content, context: childContext)
    }
}

public struct ModalPresent<R: Route>: Route {
    let content: R
    
    public init(content: R) {
        self.content = content
    }
}

public struct ModalHandler<Handler>: RouteHandler where Handler: RouteHandler {
    public let childHandler: Handler
    public let window: UIWindow

    public func perform(_ route: ModalPresent<Handler.R>, context: RouteContext?) {
        let childContext = RouteContext { controller in
            window.rootViewController?.present(controller, animated: true)
        }
        childHandler.perform(route.content, context: childContext)
    }
}
