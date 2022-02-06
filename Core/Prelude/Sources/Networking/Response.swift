//
//  Response.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation

public struct Response<Result: Decodable> {
    public let request: Request<Result>
    public let data: Result?
    public let error: Error?
    public let isCanceleed: Bool
    
    public init(request: Request<Result>, data: Result?, error: Error?, isCanceleed: Bool) {
        self.request = request
        self.data = data
        self.error = error
        self.isCanceleed = isCanceleed
    }
}
