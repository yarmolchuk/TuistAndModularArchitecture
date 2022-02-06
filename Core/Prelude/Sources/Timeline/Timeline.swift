//
//  Timeline.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation

public protocol Timeline {
    var date: Date { get }
    func schedule(on queue: DispatchQueue, work: @escaping () -> ())
}
