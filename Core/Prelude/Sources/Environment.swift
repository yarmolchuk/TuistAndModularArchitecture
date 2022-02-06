//
//  Environment.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation

public struct Environment {
    static public var timeline: Timeline = RealTimeline()
    static public var http: HTTPService = URLSession.shared
}
