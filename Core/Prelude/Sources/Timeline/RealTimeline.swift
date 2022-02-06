//
//  RealTimeline.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation

final public class RealTimeline: Timeline {
    public var date: Date { Date() }
        
    public func schedule(on queue: DispatchQueue, work: @escaping () -> ()) {
        queue.async {
            work()
        }
    }
}
