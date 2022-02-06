//
//  HTTPService.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation
import Combine

public protocol HTTPService {
    func perform<T>(request: Request<T>) -> Future<Response<T>, Never>
}
