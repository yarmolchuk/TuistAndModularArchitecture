//
//  URLSession.swift
//  Prelude
//
//  Created by Dima Yarmolchuk on 2/6/22.
//

import Foundation
import Combine

extension URLSession: HTTPService {
    public func perform<T>(request: Request<T>) -> Future<Response<T>, Never> where T : Decodable {
        Future { promise in
            self.dataTask(with: request.urlRequest) { data, response, error in
                do {
                    guard let data = data else {
                        let error = error ?? URLError(.badServerResponse)
                        return promise(.success(Response(request: request, data: nil, error: error, isCanceleed: false)))
                    }
                    
                    let result = try JSONDecoder().decode(T.self, from: data)
                    promise(.success(Response(request: request, data: result, error: nil, isCanceleed: false)))
                } catch {
                    promise(.success(Response(request: request, data: nil, error: error, isCanceleed: false)))
                }
            }.resume()
        }
    }
}
