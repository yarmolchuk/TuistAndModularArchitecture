//
//  Request.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation

public struct Request<Result: Decodable> {
    public let urlRequest: URLRequest

    public init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
}
