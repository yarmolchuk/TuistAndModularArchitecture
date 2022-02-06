//
//  TabHandler.swift
//  Routing
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import UIKit

final public class TabHandler<Handler>: RouteHandler where Handler: RouteHandler {
    public init(tabBarController: UITabBarController, handler: Handler) {
        self.tabBarController = tabBarController
        self.handler = handler
    }
    
    public let tabBarController: UITabBarController
    public let handler: Handler
    public var tabIndex: Int? = nil
    
    public func perform(_ route: Handler.R, context: RouteContext?) {
        if let index = tabIndex {
            tabBarController.selectedIndex = index
        } else {
            let childContext = RouteContext { [self] controller in
                if tabBarController.viewControllers == nil {
                    tabBarController.viewControllers = [controller]
                } else {
                    tabBarController.viewControllers?.append(controller)
                }
                tabIndex = tabBarController.viewControllers?.endIndex
            }
            handler.perform(route, context: childContext)
            context?.present(tabBarController)
        }
    }
}
