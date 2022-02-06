//
//  RouteHandler.swift
//  Routing
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import UIKit

public struct RouteContext {
    public let present: (UIViewController) -> ()
}

public protocol RouteHandler {
    associatedtype R: Route
    
    func perform(_ route: R, context: RouteContext?)
}

public extension RouteHandler {
    func wrap(in navigation: UINavigationController) -> NavigationHandler<Self> {
        NavigationHandler(handler: self, navigationController: navigation)
    }

    func wrap(in tabBar: UITabBarController) -> TabHandler<Self> {
        TabHandler(tabBarController: tabBar, handler: self)
    }
    
    func wrap(in window: UIWindow) -> CurrentNavigationHandler<Self> {
        CurrentNavigationHandler(childHandler: self, window: window)
    }
    
    func modal(in window: UIWindow) -> ModalHandler<Self> {
        ModalHandler(childHandler: self, window: window)
    }
}
